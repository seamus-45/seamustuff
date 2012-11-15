# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (graphics meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLDX"

RDEPEND="
	media-gfx/gimp
	cdistro_CLDX? (
		!media-gfx/gqview
		media-gfx/ristretto
		media-gfx/gtkam
	)
"

