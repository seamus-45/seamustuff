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
IUSE="
calculate_nodecoration
calculate_nographics
calculate_nokernel
calculate_nomultimedia
calculate_nonetwork
calculate_nonettools
calculate_noprinter
calculate_nooffice
calculate_noxfce
calculate_noxorg
calculate_nowireless
"

RDEPEND="
	!app-misc/cls-meta
	!app-misc/cldx-meta
	!app-misc/cl-dict-meta
	!app-misc/cl-desktop-meta
	!app-misc/cl-useful-meta
	!mail-client/claws-mail-gtkhtml
"

RDEPEND="${RDEPEND}
	app-misc/tm-base-meta
	app-misc/tm-tools-meta

	!calculate_noxfce? ( app-misc/tm-xfce-meta )
	!calculate_nodecoration? ( app-misc/tm-decoration-meta )
	!calculate_nographics? ( app-misc/tm-graphics-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nomultimedia? ( app-misc/tm-multimedia-meta )
	!calculate_nonetwork? ( app-misc/tm-network-meta )
	!calculate_nonettools? ( app-misc/tm-nettools-meta )
	!calculate_noprinter? ( app-misc/tm-printer-meta )
	!calculate_nooffice? ( app-misc/tm-office-meta )
	!calculate_noxorg? ( app-misc/tm-xorg-meta )
	!calculate_nowireless? ( app-misc/tm-wireless-meta )
"
# Base
RDEPEND="${RDEPEND}
	dev-python/gst-python
	lxde-base/lxdm
"

