# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 gnome2-utils git-2

DESCRIPTION="Foobnix is a free music player written on Python"
HOMEPAGE="http://www.foobnix.com/"
EGIT_REPO_URI="https://github.com/foobnix/foobnix.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/chardet
dev-python/pygobject
dev-python/simplejson
media-libs/mutagen
media-plugins/gst-plugins-meta:1.0
sys-devel/gettext
dev-python/notify-python
dev-libs/keybinder
dev-python/gst-python:1.0
media-plugins/gst-plugins-soup:1.0"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i 's/\(^Actions=.*\)/\1;/' ${S}/share/applications/foobnix.desktop
	distutils-r1_src_prepare
}

pkg_preinst() {
	gnome2_icon_savelist
	distutils-r1_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils-r1_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils-r1_pkg_postrm
}
