# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils bzr

DESCRIPTION="Dbus-binding leveraging C++-11"
HOMEPAGE="http://launchpad.net/dbus-cpp"
EBZR_REPO_URI="lp:dbus-cpp"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/process-cpp"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/add_subdirectory(tests)/d' CMakeLists.txt
	default
}
