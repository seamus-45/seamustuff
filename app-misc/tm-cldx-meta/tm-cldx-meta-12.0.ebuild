# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version Desktop XFCE (meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	!app-misc/cls-meta
	!app-misc/cl-dict-meta
	!app-misc/cl-desktop-meta
	!app-misc/cl-useful-meta
	!mail-client/claws-mail-gtkhtml
"

RDEPEND="${RDEPEND}
	app-misc/tm-tools-meta
	app-misc/tm-xfce-meta
	app-misc/tm-decoration-meta
	app-misc/tm-graphics-meta
	sys-kernel/calculate-sources 
	app-misc/tm-multimedia-meta 
	app-misc/tm-network-meta 
	app-misc/tm-nettools-meta 
	app-misc/tm-printer-meta 
	app-misc/tm-office-meta 
	app-misc/tm-xorg-meta 
	app-misc/tm-wireless-meta 
"
