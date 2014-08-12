# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="3"

inherit python

DESCRIPTION="Console XMPP client that looks like most famous IRC clients"
HOMEPAGE="http://poez.io/"
SRC_URI="http://dev.louiz.org/attachments/download/52/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#dnspython dep is optional and skipped (requires privately patched, python3 version)
DEPEND=">=dev-python/sleekxmpp-1.3.0
>=dev-python/dnspython3-1.10.0
>=dev-python/sphinx-1.1.3
>=dev-python/pyinotify-0.9.4
"
RDEPEND="${DEPEND}"

src_install()
{
	emake DESTDIR="${D}" prefix="/usr/" install || die "make install failed"
}
