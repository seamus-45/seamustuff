# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"

DESCRIPTION="LTSP Cluster accout creatinon and managment daemon agent"
HOMEPAGE="http://www.ltsp-cluster.org/"
SRC_URI="http://launchpad.net/ltsp-cluster/trunk/current/+download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"


src_install() {
	emake DESTDIR="${D}" install
    newconfd "${FILESDIR}/${PN}.confd" ${PN}
    newinitd "${FILESDIR}/${PN}.initd" ${PN}
}
