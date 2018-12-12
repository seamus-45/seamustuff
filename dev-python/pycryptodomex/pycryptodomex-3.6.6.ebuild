# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy{,3} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

MY_PN='pycryptodome'

DESCRIPTION="A self-contained cryptographic library for Python. Separate namespace version."
HOMEPAGE="https://www.pycryptodome.org https://github.com/Legrandin/pycryptodome https://pypi.org/project/pycryptodome/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-libs/gmp:0
	virtual/python-cffi[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${PV}

src_prepare() {
	default
	touch ${S}/.separate_namespace
}

python_test() {
	esetup.py test
}
