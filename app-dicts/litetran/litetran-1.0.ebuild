# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils

DESCRIPTION="LiteTran is a tiny GUI for text translation."
HOMEPAGE="https://github.com/flareguner/litetran"
SRC_URI="https://codeload.github.com/flareguner/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
  >=dev-qt/qtcore-5.2:5
  >=dev-qt/qtmultimedia-5.2:5
  >=dev-qt/qtx11extras-5.2:5"
DEPEND="${RDEPEND}
  >=dev-util/cmake-2.8.10
  >=dev-qt/linguist-tools-5.2:5
  virtual/pkgconfig"
