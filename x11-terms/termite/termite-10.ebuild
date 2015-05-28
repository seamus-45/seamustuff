# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs versionator git-r3

DESCRIPTION="A keyboard-centric VTE-based terminal"
HOMEPAGE="https://github.com/thestinger/termite"
EGIT_REPO_URI="git://github.com/thestinger/termite.git"
if [[ ${PV} != 999? ]]; then
	EGIT_COMMIT=v${PV}
fi

LICENSE="LGPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

HDEPEND=""
LIBDEPEND=">=x11-libs/gtk+-3.0
	>=x11-libs/vte-0.38.1[termite-patch]"
DEPEND="${LIBDEPEND}"
RDEPEND="${LIBDEPEND}"
[[ ${EAPI} == *-hdepend ]] || DEPEND+=" ${HDEPEND}"

pkg_pretend() {
	if ! version_is_at_least 4.7 $(gcc-version); then
		eerror "${PN} passes -std=c++11 to \${CXX} and requires a version"
		eerror "of gcc newer than 4.7.0"
	fi
}

pkg_setup() {
	CXXFLAGS="-O0 ${CXXFLAGS}"
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
