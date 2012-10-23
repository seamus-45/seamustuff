# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (Xorg meta package)"
HOMEPAGE="http://taximaxim.ru/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${RDEPEND}
	!x11-base/xorg-x11
"

# Server
RDEPEND="${RDEPEND}
	x11-base/xorg-server[-minimal]
"

#Applications
RDEPEND="${RDEPEND}
	!x11-apps/xsetmode
	x11-apps/appres
	x11-apps/bitmap
	x11-apps/iceauth
	x11-apps/luit
	x11-apps/mkfontdir
	x11-apps/mkfontscale
	x11-apps/sessreg
	x11-apps/setxkbmap
	x11-apps/smproxy
	x11-apps/x11perf
	x11-apps/xauth
	x11-apps/xbacklight
	x11-apps/xcmsdb
	x11-apps/xcursorgen
	x11-apps/xdpyinfo
	x11-apps/xdriinfo
	x11-apps/xev
	x11-apps/xf86dga
	x11-apps/xgamma
	x11-apps/xhost
	x11-apps/xinput
	x11-apps/xkbcomp
	x11-apps/xkbevd
	x11-apps/xkbutils
	x11-apps/xkill
	x11-apps/xlsatoms
	x11-apps/xlsclients
	x11-apps/xmodmap
	x11-apps/xpr
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xrdb
	x11-apps/xrefresh
	x11-apps/xset
	x11-apps/xsetroot
	x11-apps/xvinfo
	x11-apps/xwd
	x11-apps/xwininfo
	x11-apps/xwud
"

# Data
RDEPEND="${RDEPEND}
	x11-misc/xbitmaps
	x11-themes/xcursor-themes
"

# Utilities
RDEPEND="${RDEPEND}
	x11-misc/makedepend
	x11-misc/util-macros
"

# Fonts
RDEPEND="${RDEPEND}
	media-fonts/corefonts
	media-fonts/dejavu
	media-fonts/droid
"
# Other
RDEPEND="${RDEPEND}
	x11-libs/xosd
"

pkg_postinst() {
	eselect mesa set r300 gallium
	eselect mesa set r600 gallium
}
