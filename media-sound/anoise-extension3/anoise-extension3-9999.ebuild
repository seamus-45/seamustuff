# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit bzr distutils-r1

DESCRIPTION="Ambient Noise Player (media files). Brow OSSL, Brow, Pink & White Noises."
HOMEPAGE="https://launchpad.net/anoise"
EBZR_REPO_URI="lp:~costales/anoise/community-extension3"

LICENSE="CC-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
dev-python/setuptools[${PYTHON_USEDEP}]
dev-python/python-distutils-extra[${PYTHON_USEDEP}]
dev-vcs/bzr
"
