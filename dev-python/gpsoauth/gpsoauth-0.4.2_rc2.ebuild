# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="A python client library for Google Play Services OAuth."
HOMEPAGE="https://github.com/simon-weber/gpsoauth"
SRC_URI="https://github.com/simon-weber/${PN}/archive/0.4.2-rc.2.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/pycryptodome-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
"
S="${WORKDIR}/${PN}-0.4.2-rc.2"
