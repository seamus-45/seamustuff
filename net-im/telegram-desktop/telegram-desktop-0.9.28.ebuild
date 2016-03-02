# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

_qtver=5.5.1

inherit eutils gnome2-utils fdo-mime git-r3

DESCRIPTION="Desktop client of Telegram, the messaging app."
HOMEPAGE="https://telegram.org"
SRC_URI="(
	http://download.qt-project.org/official_releases/qt/${_qtver%.*}/$_qtver/single/qt-everywhere-opensource-src-${_qtver}.tar.xz
	https://github.com/telegramdesktop/tdesktop/archive/v${PV}.tar.gz -> ${P}.tar.gz
)"
EGIT_REPO_BREAKPAD='https://chromium.googlesource.com/breakpad/breakpad'
EGIT_REPO_LSS='https://chromium.googlesource.com/linux-syscall-support'

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/icu
	virtual/ffmpeg
	media-libs/jasper
	media-libs/libexif
	media-libs/libmng
	media-libs/libwebp
	x11-libs/libxkbcommon[X]
	x11-libs/gtk+:2
	sys-libs/mtdev
	>=media-libs/openal-1.16.0
	media-libs/opus
	dev-libs/glib:2
	dev-libs/libappindicator:2
	dev-libs/openssl
	media-libs/portaudio
	media-sound/pulseaudio
"

DEPEND="${RDEPEND}
	dev-libs/libunity
"

LIBRARIES=${WORKDIR}/Libraries
QSTATIC=${LIBRARIES}/QtStatic
BREAKPAD=${LIBRARIES}/breakpad

src_unpack(){
	# unpack Telegram and Qt
	default
	mv tdesktop-${PV} ${P}
	mkdir -p ${LIBRARIES}
	mv qt-everywhere-opensource-src-${_qtver} ${QSTATIC}
	# unpack breakpad
	EGIT_REPO_URI=${EGIT_REPO_BREAKPAD}
	EGIT_CHECKOUT_DIR=${BREAKPAD}
	git-r3_src_unpack
	# unpack linux syscall support plugin
	EGIT_REPO_URI=${EGIT_REPO_LSS}
	EGIT_CHECKOUT_DIR="${BREAKPAD}/src/third_party/lss"
	git-r3_src_unpack
}

src_prepare(){
	cd ${QSTATIC}/qtbase
	# Telegram uses 'slightly' patched Qt
	epatch ${S}/Telegram/_qtbase_${_qtver//./_}_patch.diff
	cd ${S}
	# add russian language
	cp ${FILESDIR}/lang_ru-${PV}.strings Telegram/SourceFiles/langs/lang_ru.strings
	epatch ${FILESDIR}/lang_ru-${PV}.patch
	echo 'OTHER_FILES += SourceFiles/langs/lang_ru.strings' >> Telegram/Telegram.pro
	# disable auto update and custom shceme
	echo 'DEFINES += TDESKTOP_DISABLE_AUTOUPDATE' >> Telegram/Telegram.pro
	echo 'DEFINES += TDESKTOP_DISABLE_REGISTER_CUSTOM_SCHEME' >> Telegram/Telegram.pro
	# resolve #383179
	echo 'DEFINES += "OF=_Z_OF"' >> Telegram/Telegram.pro
	# use shared openssl
	echo 'LIBS += -lcrypto -lssl' >> Telegram/Telegram.pro
	# use shared zlib and libxkbcommon
	sed -i 's,/usr/local/lib/libxkbcommon.a,-lxkbcommon,' Telegram/Telegram.pro
	sed -i 's,/usr/local/lib/libz.a,-lz,' Telegram/Telegram.pro
	# we do not have custom API ID
	sed -i 's,CUSTOM_API_ID,,' Telegram/Telegram.pro
	# make multi-arch libs dir to be proper for Gentoo
	sed -i 's,lib/x86_64-linux-gnu,lib64,g' Telegram/Telegram.pro
	sed -i 's,lib/i386-linux-gnu,lib32,g' Telegram/Telegram.pro
}

src_configure(){
	cd ${QSTATIC}
	./configure -prefix "${WORKDIR}/qt" \
			-release \
			-opensource \
			-confirm-license \
			-qt-libpng \
			-qt-libjpeg \
			-qt-freetype \
			-qt-harfbuzz \
			-qt-pcre \
			-qt-xcb \
			-system-zlib \
			-system-xkbcommon-x11 \
			-no-opengl \
			-static \
			-nomake examples \
			-nomake tests
	cd ${BREAKPAD}
	./configure
}

src_compile(){
	# build patched Qt
	cd ${QSTATIC}
	emake module-qtbase module-qtimageformats || die 'Make failed'
	emake module-qtbase-install_subtargets module-qtimageformats-install_subtargets || die 'Make failed'
	export PATH="${WORKDIR}/qt/bin:$PATH"

	# build google breakpad
	cd ${BREAKPAD}
	emake || die 'Make failed'
	
	# build MetaStyle
	mkdir -p ${S}/Linux/DebugIntermediateStyle
	cd ${S}/Linux/DebugIntermediateStyle
	qmake CONFIG+=debug ${S}/Telegram/MetaStyle.pro
	emake || die 'Make failed'

	# build MetaLang
	mkdir -p ${S}/Linux/DebugIntermediateLang
	cd ${S}/Linux/DebugIntermediateLang
	qmake CONFIG+=debug ${S}/Telegram/MetaLang.pro
	emake || die 'Make failed'

	# Build Telegram Desktop
	mkdir -p ${S}/Linux/ReleaseIntermediate
	cd ${S}/Linux/ReleaseIntermediate
	qmake CONFIG+=release ${S}/Telegram/Telegram.pro
	emake $(awk '$1 == "PRE_TARGETDEPS" { $1=$2="" ; print }' ${S}/Telegram/Telegram.pro) || die 'Make failed'
	qmake CONFIG+=release ${S}/Telegram/Telegram.pro
	emake || die 'Make failed'
}

src_install(){
	newbin ${S}/Linux/Release/Telegram telegram-desktop
	insopts -m644
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s ${icon_size} ${S}/Telegram/SourceFiles/art/icon${icon_size}.png telegram-desktop.png
	done
	make_desktop_entry ${PN} "Telegram" ${PN} "Network;" "MimeType=application/x-xdg-protocol-tg;x-scheme-handler/tg;\n"
}

pkg_postinst(){
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
