# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

_qtver=5.6.2

inherit eutils gnome2-utils fdo-mime git-r3

DESCRIPTION="Desktop client of Telegram, the messaging app."
HOMEPAGE="https://telegram.org"
SRC_URI="(
	http://download.qt.io/official_releases/qt/${_qtver%.*}/${_qtver}/submodules/qtbase-opensource-src-${_qtver}.tar.xz
	http://download.qt.io/official_releases/qt/${_qtver%.*}/${_qtver}/submodules/qtimageformats-opensource-src-${_qtver}.tar.xz
)"
EGIT_REPO_URI="git://github.com/telegramdesktop/tdesktop.git"
EGIT_COMMIT="v${PV}"
GYP_REPO_URI="https://chromium.googlesource.com/external/gyp"
GYP_COMMIT="702ac58e4772"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=media-video/ffmpeg-3.2.0
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
	dev-libs/google-breakpad
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
	>=dev-util/cmake-3.6.2
	app-admin/chrpath	
"

LIBRARIES=${WORKDIR}/Libraries
QTSRC=${LIBRARIES}/Qt
GYP=${LIBRARIES}/gyp

src_unpack(){
	# unpack Qt
	default
	# unpack Telegram
	git-r3_src_unpack
	mv tdesktop-${PV} ${P}
	mkdir -p ${QTSRC}
	mv ${WORKDIR}/qtbase-opensource-src-${_qtver} ${QTSRC}/qtbase
	mv ${WORKDIR}/qtimageformats-opensource-src-${_qtver} ${QTSRC}/qtimageformats
	# unpack Gyp
	EGIT_CHECKOUT_DIR=${GYP}
	EGIT_REPO_URI="${GYP_REPO_URI}"
	EGIT_COMMIT="${GYP_COMMIT}"
	git-r3_src_unpack
}

src_prepare(){
	cd ${QTSRC}/qtbase
	# Telegram uses 'slightly' patched Qt
	epatch ${S}/Telegram/Patches/qtbase_${_qtver//./_}.diff
	cd ${GYP}
	git apply ${S}/Telegram/Patches/gyp.diff || die "Patch failed"

	cd ${S}
	# add russian language and fix gyp
	cp ${FILESDIR}/lang_ru-${PV}.strings ${S}/Telegram/Resources/langs/lang_ru.strings
	epatch ${FILESDIR}/lang_ru-${PV}.patch
	epatch ${FILESDIR}/gyp-fixes-${PV}.patch
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
			-no-gtkstyle \
			-no-opengl \
			-static \
			-nomake examples \
			-nomake tests
}

src_compile(){
	# build patched Qt
	cd ${QTSRC}/qtbase
	emake || die 'Make failed'
	emake install || die 'Make failed'
	export PATH="${WORKDIR}/qt/bin:${PATH}"
	cd ${QTSRC}/qtimageformats
	qmake .
	emake || die 'Make failed'
	emake install || die 'Make failed'

	# Build Telegram Desktop
	cd ${S}/Telegram/gyp
	${GYP}/gyp \
		-Dlinux_path_qt="${WORKDIR}/qt" \
		-DOF=_Z_OF \
		-Dlinux_lib_ssl=-lssl \
		-Dlinux_lib_crypto=-lcrypto \
		-Dlinux_lib_icu="-licuuc -licutu -licui18n" \
		--depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp --format=cmake || die "Gyp failed"
	cd ${S}/out/Release
	cmake . || die "Cmake failed"
	emake || die 'Make failed'
	chrpath --delete Telegram
}

src_install(){
	newbin ${S}/out/Release/Telegram ${PN}
	insopts -m644
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s ${icon_size} ${S}/Telegram/Resources/art/icon${icon_size}.png ${PN}.png
	done
	make_desktop_entry "${PN} -- %u" "Telegram" ${PN} "Network;" "MimeType=x-scheme-handler/tg;"
}

pkg_postinst(){
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
