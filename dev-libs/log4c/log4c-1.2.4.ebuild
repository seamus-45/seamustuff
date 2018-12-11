# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="C classes for flexible logging to files, syslog and other destinations."
HOMEPAGE="http://log4c.sourceforge.net/"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/expat
"

src_configure() {
	econf --sysconfdir="${EPREFIX}"/etc/"${PN}"
}
