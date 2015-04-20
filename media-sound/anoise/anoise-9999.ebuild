# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit bzr distutils-r1 gnome2-utils

DESCRIPTION="Ambient Noise Player. Integrate noise into your sound indicator and relax or concentrate."
HOMEPAGE="https://launchpad.net/anoise"
EBZR_REPO_URI="lp:anoise"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+extension1 +extension2 +extension3"

RDEPEND="dev-python/gst-python:0.10
media-libs/gstreamer:0.10[introspection]
x11-libs/gtk+:3[introspection]
media-sound/anoise-media
extension1? ( media-sound/anoise-extension1 )
extension2? ( media-sound/anoise-extension2 )
extension3? ( media-sound/anoise-extension3 )
"
DEPEND="${RDEPEND}
dev-python/setuptools[${PYTHON_USEDEP}]
dev-python/python-distutils-extra[${PYTHON_USEDEP}]
dev-vcs/bzr
"

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
