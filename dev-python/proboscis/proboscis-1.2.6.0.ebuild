# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Proboscis is a Python test framework that extends Python’s built-in unittest module and Nose with features from TestNG."
HOMEPAGE="https://pypi.org/project/proboscis/"
SRC_URI="https://files.pythonhosted.org/packages/3c/c8/c187818ab8d0faecdc3c16c1e0b2e522f3b38570f0fb91dcae21662019d0/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
