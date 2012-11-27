# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3 and Creative Commons Attribution-Share Alike 3.0
# $Header: $

EAPI="4"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="git://github.com/shimmerproject/${PN}.git"
    GIT_ECLASS="git-2"
fi

inherit $GIT_ECLASS

DESCRIPTION="Shimmer project - Elementary icons forked from upstream, extended and
maintained for Xfce"
HOMEPAGE="https://github.com/shimmerproject/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-themes/tango-icon-theme-0.8.90
		>=media-gfx/cldx-themes-12.0-r1"

S="${WORKDIR}/${PN}"

src_prepare() {
	find "${S}" -type d -maxdepth 1 -name '.git' -exec rm -rf '{}' \;
	find "${S}" -type f -maxdepth 1 -name '.gitignore' -exec rm -f '{}' \;
	find "${S}" -type f -name 'README' -exec rm -f '{}' \;
	einfo "Remove unnecessary .git files"
	find "${S}" -type f -name 'pidgin*' -exec rm -f '{}' \;
	find "${S}" -type l -name 'pidgin*' -exec rm -f '{}' \;
	einfo "Remove elementary pidgin icons"
}

src_install() {
	insinto /usr/share/icons
	doins -r ${S}/${PN}
	doins -r ${S}/${PN}-dark
	default
}
