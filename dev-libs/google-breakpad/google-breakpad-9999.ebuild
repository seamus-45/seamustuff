# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="An open-source multi-platform crash reporting system"
HOMEPAGE="https://chromium.googlesource.com/breakpad/breakpad/"
EGIT_REPO_URI='https://chromium.googlesource.com/breakpad/breakpad'
EGIT_REPO_LSS='https://chromium.googlesource.com/linux-syscall-support'

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack(){
	git-r3_src_unpack
	# unpack linux syscall support plugin
	EGIT_REPO_URI=${EGIT_REPO_LSS}
	EGIT_CHECKOUT_DIR="${S}/src/third_party/lss"
	git-r3_src_unpack
}
