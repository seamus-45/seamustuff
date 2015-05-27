# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3

DESCRIPTION="Outputs X window titles"
HOMEPAGE="https://github.com/baskerville/xtitle"
EGIT_REPO_URI="git://github.com/baskerville/xtitle"

LICENSE="public-domain"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libxcb"
RDEPEND="${DEPEND}"

src_compile() {
	emake xtitle
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
