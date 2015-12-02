# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit fdo-mime gnome2-utils

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade"
SRC_URI="https://github.com/jliljebl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pygobject:3
	dev-python/dbus-python
	dev-python/pycairo
	dev-python/numpy
	dev-python/pillow
	media-libs/mlt[python]
	media-plugins/frei0r-plugins
	media-plugins/swh-plugins
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}-trunk"

src_prepare() {
	sed -i 's@/usr/share/flowblade/Flowblade@/usr/share/flowblade@' ${S}/flowblade
}

src_install() {
	dobin ${PN}

	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/${PN}.png
	domenu installdata/${PN}.desktop

	insinto /usr/share/mime/packages/
	doins installdata/${PN}.xml
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
