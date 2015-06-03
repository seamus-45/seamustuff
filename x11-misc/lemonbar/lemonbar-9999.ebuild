# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Lightweight xcb based bar."
HOMEPAGE="https://github.com/LemonBoy/bar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft"

if use xft; then
	EGIT_REPO_URI="https://github.com/krypt-n/bar.git -> ${P}"
	EGIT_BRANCH="xft-port"
else
	EGIT_REPO_URI="https://github.com/LemonBoy/bar.git -> ${P}"
fi

DEPEND="
x11-libs/libxcb
xft? ( x11-libs/libXft )"
RDEPEND="${DEPEND}"

src_compile() {
	make all
	make doc
}

src_install() {
	emake DESTDIR="${D}" install
	doman ${PN}.1
}
