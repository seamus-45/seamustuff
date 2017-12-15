# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils bzr

DESCRIPTION="C++11 library for handling processes"
HOMEPAGE="http://launchpad.net/process-cpp"
EBZR_REPO_URI="lp:process-cpp"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/properties-cpp"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/add_subdirectory(tests)/d' CMakeLists.txt
	default
}
