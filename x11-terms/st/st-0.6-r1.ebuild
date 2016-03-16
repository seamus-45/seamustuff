# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib savedconfig toolchain-funcs

DESCRIPTION="Simple terminal implementation for X with custom patches"
HOMEPAGE="http://st.suckless.org/"
SRC_URI="http://dl.suckless.org/st/${P}.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="savedconfig monokai droid"

REQUIRED_USE="
savedconfig? ( !monokai !droid )
"

#	!<sys-libs/ncurses-6.0 (conflict with lftp and pinentry)
RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xproto
"

src_prepare() {
	epatch_user

	sed -e '/^CFLAGS/s:[[:space:]]-O[^[:space:]]*[[:space:]]: :' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-i config.mk || die
	sed -e '/@echo/!s:@::' \
		-e '/tic/d' \
		-i Makefile || die
	tc-export CC

	if use savedconfig; then
		restore_config config.h
	else
		emake config.h
	fi

	if use monokai; then
		epatch "${FILESDIR}"/${P}-monokai.patch
	fi
	if use droid; then
		epatch "${FILESDIR}"/${P}-droid.patch
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install

	dodoc TODO

	make_desktop_entry ${PN} simpleterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}
