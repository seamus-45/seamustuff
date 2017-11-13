# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils eutils

DESCRIPTION="A simple screenshot tool"
HOMEPAGE="http://lightscreen.com.ar/"
EGIT_REPO_URI="https://github.com/ckaiser/${PN}.git"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
  >=dev-util/cmake-2.8.10
  virtual/pkgconfig"
RDEPEND="${DEPEND}
  >=dev-qt/qtcore-5.7.1:5
  >=dev-qt/qtgui-5.7.1:5
  >=dev-qt/qtwidgets-5.7.1:5
  >=dev-qt/qtnetwork-5.7.1:5
  >=dev-qt/qtsql-5.7.1:5
  >=dev-qt/qtmultimedia-5.7.1:5
  >=dev-qt/qtconcurrent-5.7.1:5
  >=dev-qt/qtx11extras-5.7.1:5
"

src_prepare() {
  epatch "${FILESDIR}"/screenshot_cpp_h_fix.patch
  default
}

src_compile() {
  eqmake5
  emake
}

src_install() {
  dobin lightscreen
  dodoc LICENSE README.md
}
