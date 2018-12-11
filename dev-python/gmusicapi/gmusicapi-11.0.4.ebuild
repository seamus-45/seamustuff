# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="an unofficial API for Google Play Music"
HOMEPAGE="https://github.com/simon-weber/gmusicapi"
SRC_URI="https://github.com/simon-weber/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/MechanicalSoup-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/appdirs-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.5.1[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.0.10[${PYTHON_USEDEP}]
	>=dev-python/future-0.15.2[${PYTHON_USEDEP}]
	>=dev-python/gpsoauth-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9.2[${PYTHON_USEDEP}]
	>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pbr-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/proboscis-1.2.6.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.8[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.4.2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.5.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.2[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.4.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/validictory-1.0.2[${PYTHON_USEDEP}]
	>=dev-libs/protobuf-3.0.0
	>=media-libs/mutagen-1.34.1[$PYTHON_USEDEP]
"
