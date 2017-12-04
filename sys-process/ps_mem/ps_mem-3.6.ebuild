# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )
DISTUTILS_SINGLE_IMPL=true

inherit distutils-r1


DESCRIPTION='A utility to accurately report the in core memory usage for a program'
HOMEPAGE="https://github.com/pixelb/ps_mem"
SRC_URI="https://github.com/pixelb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"


LICENSE='LGPL-2.1'
SLOT='0'
KEYWORDS='~amd64 ~x86'
IUSE=""

python_install_all() {
	doman "${PN}.1"

	distutils-r1_python_install_all
}
