# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite?,threads"
inherit distutils-r1

DESCRIPTION="Cross-plattform SQL client for a variety of DBMS."
HOMEPAGE="http://crunchyfrog.googlecode.com/"
SRC_URI="http://crunchyfrog.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="firebird mssql mysql postgres sqlite excel"

RDEPEND=">=dev-python/pygtk-2.12
	>=dev-python/pygobject-2.14
	>=dev-python/pycairo-1.4.0
	>=dev-python/pygtksourceview-2.4.0
	>=dev-python/configobj-4.4.0
	>=dev-python/python-sqlparse-0.1.1
	>=dev-python/pyxdg-0.15
	dev-python/ipython
	excel? ( dev-python/xlwt )
	firebird? ( dev-python/kinterbasdb )
	mssql? ( dev-python/pymssql )
	mysql? ( dev-python/mysql-python )
	postgres? ( dev-python/psycopg:2 )"
DEPEND="dev-python/sphinx"

PYTHON_MODNAME="cf"

src_prepare() {
	distutils-r1_src_prepare
	sed -i \
		-e "s|/usr/share/doc/crunchyfrog/manual/|/usr/share/doc/${PF}/html|" \
		cf/__init__.py || die "sed failed"
}

src_install() {
	DOCS="CHANGES"
	distutils-r1_src_install

	dohtml -r "${D}"/usr/share/doc/crunchyfrog/manual/*
	rm -rf "${D}/usr/share/doc/crunchyfrog"
	sed -i \
		-e "s|PREFIX.*|PREFIX = '/usr'|" \
		"${D}"/usr/lib64/python2.7/site-packages/cf/local_config.py
	sed -i \
		-e "s|sql|sql;|" \
		"${D}"/usr/share/applications/crunchyfrog.desktop
}
