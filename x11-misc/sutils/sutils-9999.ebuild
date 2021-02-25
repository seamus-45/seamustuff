# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit git-r3

DESCRIPTION="Small command line utilities"
HOMEPAGE="https://github.com/baskerville/sutils"
EGIT_REPO_URI="git://github.com/baskerville/sutils"

LICENSE="public-domain"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libxcb"
RDEPEND="${DEPEND}"

src_compile() {
	# I'm sure this is frowned upon
	emake $(basename -s .c -a *.c)
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
