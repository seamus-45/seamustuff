# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (decoration meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop cdistro_CLDX"

RDEPEND="
	!x11-themes/xfce4-icon-theme
	media-gfx/splashutils

	cdistro_CLDX? (
		media-gfx/cldx-themes
		x11-themes/gnome-themes-standard
		x11-themes/gnome-icon-theme
		x11-themes/tango-icon-theme
		x11-themes/Albatross
	)
"

