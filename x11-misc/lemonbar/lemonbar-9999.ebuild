# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Lightweight xcb based bar."
HOMEPAGE="https://github.com/LemonBoy/bar"
EGIT_REPO_URI="https://github.com/LemonBoy/bar.git -> ${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft"

DEPEND="
x11-libs/libxcb
xft? ( x11-libs/libXft )"
RDEPEND="${DEPEND}"

src_unpack() {
	if use xft; then
		EGIT_REPO_URI="https://github.com/krypt-n/bar.git -> ${P}"
		EGIT_BRANCH="xft-port"
	fi
	git-r3_src_unpack
}

src_prepare() {
	epatch ${FILESDIR}/buffer-bug-fix.patch
}

src_compile() {
	emake all
	emake doc
}

src_install() {
	emake DESTDIR="${D}" install
	doman ${PN}.1
}
