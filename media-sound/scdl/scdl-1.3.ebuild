# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python Soundcloud Music Downloader"
HOMEPAGE="https://github.com/flyingrub/scdl"
SRC_URI="https://github.com/flyingrub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/termcolor[${PYTHON_USEDEP}]
dev-python/wget[${PYTHON_USEDEP}]
dev-python/soundcloud-python[${PYTHON_USEDEP}]
dev-python/docopt[${PYTHON_USEDEP}]
media-libs/mutagen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
