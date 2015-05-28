# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools git-r3

DESCRIPTION="Improved fork of simple screen lock application for X server."
HOMEPAGE="https://github.com/Arkq/alock"
EGIT_REPO_URI="git://github.com/Arkq/alock.git"
if [[ ${PV} != 999? ]]; then
	EGIT_COMMIT=v${PV}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="imlib pam dunst"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXcursor
	imlib? ( media-libs/imlib2[X] )
	pam? ( virtual/pam )
	dunst? ( x11-misc/dunst )"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--prefix=/usr \
		--enable-passwd \
		--enable-hash \
		--enable-xrender \
		--enable-xcursor \
		--enable-xpm \
		$(use_enable pam) \
		$(use_enable imlib imlib2) \
		$(use_with dunst) || die
}

