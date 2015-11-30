# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils multilib savedconfig toolchain-funcs

DESCRIPTION="Simple terminal implementation for X with solarized theme"
HOMEPAGE="http://st.suckless.org/
https://github.com/altercation/solarized"
SRC_URI="http://dl.suckless.org/st/${P}.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="
solarized_dark? ( !solarized_light !monokai )
solarized_light? ( !solarized_dark !monokai )
monokai? ( !solarized_light !solarized_dark )
savedconfig? ( !solarized_light !solarized_dark !droid !monokai )
"
IUSE="savedconfig solarized_dark solarized_light droid nobold monokai"

RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft"
DEPEND="
	${RDEPEND}
	sys-libs/ncurses
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xproto
"

src_prepare() {
	cp ${S}/config.def.h ${S}/config.h
	if use solarized_light; then
		epatch "${FILESDIR}"/config-h-solarized_light.patch
	elif use solarized_dark; then
		epatch "${FILESDIR}"/config-h-solarized_dark.patch
	elif use monokai; then
		epatch "${FILESDIR}"/config-h-monokai.patch
	fi
	if use droid; then
		epatch "${FILESDIR}"/config-h-droid.patch
	fi
	if use nobold; then
		epatch "${FILESDIR}"/c-no_bold_colors.patch
	fi

	sed -e '/^CFLAGS/s:[[:space:]]-O[^[:space:]]*[[:space:]]: :' \
			-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
			-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
			-i config.mk || die
	sed -e '/@echo/!s:@::' \
			-i Makefile || die
	tc-export CC

	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	tic -s -o "${ED}"/usr/share/terminfo st.info || die
	dodoc TODO

	make_desktop_entry ${PN} simpleterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}

pkg_postinst() {
	if ! [[ "${REPLACING_VERSIONS}" ]]; then
		elog "Please ensure a usable font is installed, like"
		elog "    media-fonts/corefonts"
		elog "    media-fonts/dejavu"
		elog "    media-fonts/urw-fonts"
	fi
}
