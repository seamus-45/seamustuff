# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 git-r3

DESCRIPTION="A Python wrapper around the Soundcloud API"
HOMEPAGE="https://github.com/soundcloud/soundcloud-python"
EGIT_REPO_URI="https://github.com/soundcloud/soundcloud-python"

LICENSE="https://raw.githubusercontent.com/soundcloud/soundcloud-python/master/LICENSE"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-python/nose-1.1.2[${PYTHON_USEDEP}]
>=dev-python/fudge-1.0.3[${PYTHON_USEDEP}]
>=dev-python/requests-1.0.0[${PYTHON_USEDEP}]
>=dev-python/simplejson-2.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
