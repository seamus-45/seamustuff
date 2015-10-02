# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3 and Creative Commons Attribution-Share Alike 3.0
# $Header: $

EAPI="4"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="git://github.com/shimmerproject/${PN}.git"
    GIT_ECLASS="git-2"
fi

inherit $GIT_ECLASS

DESCRIPTION="Shimmer project themes for GTK+ 2,3 and xfwm4"
HOMEPAGE="http://shimmerproject.org/project/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-themes/gtk-engines-unico-1.0.1
	>=x11-themes/gtk-engines-murrine-0.90
	dev-ruby/sass"

S="${WORKDIR}/${PN}"
