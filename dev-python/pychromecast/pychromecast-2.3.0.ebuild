# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Library for Python 3 to communicate with the Google Chromecast."
HOMEPAGE="https://github.com/balloob/pychromecast"
SRC_URI="https://github.com/balloob/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.17.7[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.17.7[${PYTHON_USEDEP}]
	>=dev-python/casttube-0.2.0[${PYTHON_USEDEP}]
	>=dev-libs/protobuf-3.0.0
"
