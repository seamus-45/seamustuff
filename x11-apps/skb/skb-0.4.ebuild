# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Simple keyboard layout indicator"
HOMEPAGE="http://plhk.ru/"
SRC_URI="http://plhk.ru/static/skb/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND_COMMON=""
RDEPEND="
	${DEPEND_COMMON}
	"
DEPEND="
	${DEPEND_COMMON}
	"
S="${WORKDIR}/${PN}-${PV}"

src_install() {
	insinto /usr/bin/
	dobin skb || die
}
