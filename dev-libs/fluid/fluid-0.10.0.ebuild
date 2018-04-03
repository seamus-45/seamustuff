# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Library for QtQuick apps with Material Design and Universal."
HOMEPAGE="https://github.com/lirios/fluid"
SRC_URI="https://github.com/lirios/fluid/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="debug +icons"

RDEPEND=">=dev-qt/qtdeclarative-5.8.0:5
	>=dev-qt/qtquickcontrols2-5.8.0:5
	>=dev-qt/qtgraphicaleffects-5.8.0:5
	>=dev-qt/qtsvg-5.8.0:5
	kde-frameworks/extra-cmake-modules
"
DEPEND="${RDEPEND}"

CMAKE_MIN_VERSION="2.8.12"
DOCS=( AUTHORS.md README.md )

src_prepare() {
	if use icons; then
		${S}/scripts/fetch_icons.sh || die "Cannot download icons"
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
		-DCMAKE_INSTALL_PREFIX=/usr
	)

	cmake-utils_src_configure
}
