# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Create animated GIFs, overlaid with optional text, from video files"
HOMEPAGE="https://github.com/lettier/gifcurry"
SRC_URI="https://github.com/lettier/gifcurry/releases/download/${PV}/gifcurry-linux-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	media-video/ffmpeg
	media-gfx/imagemagick
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-plugins/gst-plugins-libav
"
DEPEND="${RDEPEND}"

QA_PREBUILT="opt/${PN}/*"

S="${WORKDIR}/gifcurry-linux-${PV}"

src_install() {
	insinto ${EPREFIX}/opt/${PN}
	doins -r ${S}/*
	dosym ${EPREFIX}/opt/${PN}/bin/gifcurry_gui ${EPREFIX}/usr/bin/gifcurry_gui
	dosym ${EPREFIX}/opt/${PN}/bin/gifcurry_cli ${EPREFIX}/usr/bin/gifcurry_cli
	fperms a+x ${EPREFIX}/opt/${PN}/bin/*
	insinto ${EPREFIX}/usr/share/icons/hicolor/scalable/apps/
	doins ${S}/share/icons/hicolor/scalable/apps/gifcurry-icon.svg
	insinto ${EPREFIX}/usr/share/applications/
	doins ${S}/share/applications/gifcurry.desktop
}
