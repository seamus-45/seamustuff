# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake

CMAKE_BUILD_TYPE="Release"

DESCRIPTION="Qt RPC for neovim"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
SRC_URI="https://github.com/equalsraf/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gcov +msgpack"

DEPEND="
	msgpack? ( dev-libs/msgpack )
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	app-editors/neovim"

src_configure() {
	local mycmakeargs=(
		-DUSE_GCOV=$(usex gcov ON OFF)
		-DUSE_SYSTEM_MSGPACK=$(usex msgpack ON OFF)
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}
