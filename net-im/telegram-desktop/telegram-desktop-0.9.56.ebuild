# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

_qtver=5.6.0

inherit eutils gnome2-utils fdo-mime git-r3

DESCRIPTION="Desktop client of Telegram, the messaging app."
HOMEPAGE="https://telegram.org"
SRC_URI="(
	http://download.qt.io/official_releases/qt/${_qtver%.*}/${_qtver}/submodules/qtbase-opensource-src-${_qtver}.tar.xz
	http://download.qt.io/official_releases/qt/${_qtver%.*}/${_qtver}/submodules/qtimageformats-opensource-src-${_qtver}.tar.xz
	https://github.com/telegramdesktop/tdesktop/archive/v${PV}.tar.gz -> ${P}.tar.gz
)"
EGIT_REPO_BREAKPAD='https://chromium.googlesource.com/breakpad/breakpad'
EGIT_REPO_LSS='https://chromium.googlesource.com/linux-syscall-support'

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	virtual/ffmpeg
	dev-libs/icu
	media-libs/jasper
	media-libs/libmng
	x11-libs/libxkbcommon[X]
	dev-libs/libinput
	net-libs/libproxy
	>=media-libs/openal-1.16.0[portaudio]
	x11-libs/tslib
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-image
	x11-libs/xcb-util-renderutil
	x11-themes/hicolor-icon-theme
	media-libs/opus
	dev-libs/openssl
	sys-libs/zlib
"

DEPEND="${RDEPEND}
	dev-libs/libappindicator:2
	dev-libs/libunity
	x11-libs/libva[opengl]
	sys-libs/mtdev
	media-libs/libexif
	media-libs/libwebp
	x11-libs/libXrender
	x11-libs/libXi
	dev-db/sqlite
	x11-libs/xcb-util-image
	media-libs/harfbuzz[icu]
	x11-libs/libSM
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/tiff
"

LIBRARIES=${WORKDIR}/Libraries
QTSRC=${LIBRARIES}/Qt
BREAKPAD=${LIBRARIES}/breakpad

src_unpack(){
	# unpack Telegram and Qt
	default
	mv tdesktop-${PV} ${P}
	mkdir -p ${QTSRC}
	mv ${WORKDIR}/qtbase-opensource-src-${_qtver} ${QTSRC}/qtbase
	mv ${WORKDIR}/qtimageformats-opensource-src-${_qtver} ${QTSRC}/qtimageformats
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
	cd ${QTSRC}/qtbase
	# Telegram uses 'slightly' patched Qt
	epatch ${S}/Telegram/Patches/qtbase_${_qtver//./_}.diff
	cd ${S}
	# add russian language
	cp ${FILESDIR}/lang_ru-${PV}.strings ${S}/Telegram/Resources/langs/lang_ru.strings
	epatch ${FILESDIR}/lang_ru-${PV}.patch
	echo 'OTHER_FILES += SourceFiles/langs/lang_ru.strings' >> ${S}/Telegram/Telegram.pro
	# disable auto update and custom shceme
	echo 'DEFINES += TDESKTOP_DISABLE_AUTOUPDATE' >> ${S}/Telegram/Telegram.pro
	echo 'DEFINES += TDESKTOP_DISABLE_REGISTER_CUSTOM_SCHEME' >> ${S}/Telegram/Telegram.pro
	echo 'DEFINES += TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION' >> ${S}/Telegram/Telegram.pro
	# resolve #383179
	echo 'DEFINES += "OF=_Z_OF"' >> ${S}/Telegram/Telegram.pro
	# use shared openssl
	echo 'LIBS += -lcrypto -lssl' >> ${S}/Telegram/Telegram.pro
	# use shared zlib and libxkbcommon
	sed -i 's,/usr/local/lib/libxkbcommon.a,-lxkbcommon,' ${S}/Telegram/Telegram.pro
	sed -i 's,/usr/local/lib/libz.a,-lz,' ${S}/Telegram/Telegram.pro
	# we do not have custom API ID
	sed -i '/CUSTOM_API_ID/d' ${S}/Telegram/Telegram.pro
	# make multi-arch libs dir to be proper for Gentoo
	sed -i 's,lib/x86_64-linux-gnu,lib64,g' ${S}/Telegram/Telegram.pro
	sed -i 's,lib/i386-linux-gnu,lib32,g' ${S}/Telegram/Telegram.pro
}

src_configure(){
	cd ${QTSRC}/qtbase
	./configure -prefix "${WORKDIR}/qt" \
			-release \
			-opensource \
			-confirm-license \
			-system-zlib \
			-system-libpng \
			-system-libjpeg \
			-system-freetype \
			-system-harfbuzz \
			-system-pcre \
			-system-xcb \
			-system-xkbcommon-x11 \
			-no-opengl \
			-no-gtkstyle \
			-static \
			-nomake examples \
			-nomake tests
	cd ${BREAKPAD}
	./configure
}

src_compile(){
	# build patched Qt
	cd ${QTSRC}/qtbase
	emake || die 'Make failed'
	emake install || die 'Make failed'
	export PATH="${WORKDIR}/qt/bin:$PATH"
	cd ${QTSRC}/qtimageformats
	qmake .
	emake || die 'Make failed'
	emake install || die 'Make failed'

	# build breakpad
	cd ${BREAKPAD}
	emake || die 'Make failed'
	
	# build codegen_style
	mkdir -p ${S}/Linux/obj/codegen_style/Release
	cd ${S}/Linux/obj/codegen_style/Release
	qmake CONFIG+=release ${S}/Telegram/build/qmake/codegen_style/codegen_style.pro
	emake || die "Make failed"

	# build codegen_numbers
	mkdir -p ${S}/Linux/obj/codegen_numbers/Release
	cd ${S}/Linux/obj/codegen_numbers/Release
	qmake CONFIG+=release ${S}/Telegram/build/qmake/codegen_numbers/codegen_numbers.pro
	emake || die "Make failed"

	# build MetaLang
	mkdir -p ${S}/Linux/ReleaseIntermediateLang
	cd ${S}/Linux/ReleaseIntermediateLang
	qmake CONFIG+=release ${S}/Telegram/MetaLang.pro
	emake || die 'Make failed'

	# Build Telegram Desktop
	mkdir -p ${S}/Linux/ReleaseIntermediate
	cd ${S}/Linux/ReleaseIntermediate

	${S}/Linux/codegen/Release/codegen_style \
		"-I${S}/Telegram/Resources" \
		"-I${S}/Telegram/SourceFiles" \
		"-o${S}/Telegram/GeneratedFiles/styles" \
		all_files.style --rebuild

	${S}/Linux/codegen/Release/codegen_numbers \
		"-o${S}/Telegram/GeneratedFiles" \
		"${S}/Telegram/Resources/numbers.txt"

	${S}/Linux/ReleaseLang/MetaLang \
		-lang_in ${S}/Telegram/Resources/langs/lang.strings \
		-lang_out ${S}/Telegram/GeneratedFiles/lang_auto

	qmake CONFIG+=release QT_TDESKTOP_PATH="${WORKDIR}/qt" ${S}/Telegram/Telegram.pro
	emake || die 'Make failed'
}

src_install(){
	newbin ${S}/Linux/Release/Telegram telegram-desktop
	insopts -m644
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s ${icon_size} ${S}/Telegram/Resources/art/icon${icon_size}.png telegram-desktop.png
	done
	make_desktop_entry "${PN} %u" "Telegram" ${PN} "Network;" "MimeType=application/x-xdg-protocol-tg;x-scheme-handler/tg;\n"
}

pkg_postinst(){
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
