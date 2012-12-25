# Copyright 1999-2009 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

DESCRIPTION="Desktop daemon for advanced window manipulations."
HOMEPAGE="http://launchpad.net/winwrangler"
SRC_URI="http://launchpad.net/winwrangler/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=x11-libs/libwnck-2.22
	dev-libs/glib:2
	x11-libs/gtk+:2
	=x11-libs/gtkhotkey-0.2*"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

src_configure() {
	# there are no docs (atm)
	econf \
		--disable-gtk-doc
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}/usr/share/doc/winwrangler"

	dodoc AUTHORS ChangeLog HACKING NEWS README
}
