# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit webapp eutils

DESCRIPTION="LTSP Cluster control center"
HOMEPAGE="http://www.ltsp-cluster.org/"
SRC_URI="http://launchpad.net/ltsp-cluster/trunk/current/+download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	virtual/httpd-basic
	>=dev-lang/php-5[postgres,session]
	dev-php/adodb
	dev-php/pear
	dev-db/pygresql"
	

src_prepare() {
	epatch "${FILESDIR}/${P}-dbfunctions.patch"
}

src_install() {
	# webapp
	webapp_src_preinst
	cp -R Admin DB Tech Terminal ${D}/${MY_HTDOCSDIR}
	webapp_configfile ${MY_HTDOCSDIR}/Admin/util/config.php
	webapp_postinst_txt en "${FILESDIR}/postinstall.txt"
	webapp_src_install
	
	# documentation
	dodoc AUTHORS
	
	# scripts
	insinto "/usr/share/ltsp-cluster-control"
	doins scripts/*
}