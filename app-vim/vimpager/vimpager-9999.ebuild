# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

inherit eutils git-2

DESCRIPTION="less.sh replacement"
HOMEPAGE="https://github.com/rkitover/vimpager"
EGIT_REPO_URI="git://github.com/rkitover/vimpager.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""

DEPEND="app-arch/sharutils"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/disable-doc.patch
}

src_install() {
	PREFIX="/usr" emake DESTDIR="${D}" install || die
}
