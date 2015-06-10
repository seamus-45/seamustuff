# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 gnome2-utils

DESCRIPTION="Foobnix is a free music player written on Python"
HOMEPAGE="http://www.foobnix.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/chardet
dev-python/pygobject
dev-python/simplejson
media-libs/mutagen
media-plugins/gst-plugins-meta:0.10
sys-devel/gettext
dev-python/notify-python
dev-libs/keybinder
dev-python/gst-python:0.10
dev-pythoh/bsddb3"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i 's/\(^Actions=.*\)/\1;/' ${S}/share/applications/foobnix.desktop
	distutils-r1_src_prepare
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
