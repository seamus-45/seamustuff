# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://flameshot.js.org"
SRC_URI="https://github.com/lupoDharkael/flameshot/archive/v0.6.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-qt/linguist-tools
"

src_configure() {
	eqmake5 PREFIX="${D}"/usr CONFIG+=packaging
}
