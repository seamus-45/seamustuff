# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 mercurial

DESCRIPTION="Pure python download utility"
HOMEPAGE="https://bitbucket.org/techtonik/python-wget/"
EHG_REPO_URI="https://bitbucket.org/techtonik/python-wget/src"
HG_DEPEND="dev-vcs/mercurial"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
