# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Simple screen ruler for x11"
HOMEPAGE="https://github.com/6d7367/xscreenruler"
EGIT_REPO_URI="https://github.com/6d7367/xscreenruler"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe xscreenruler
}
