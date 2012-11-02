# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (tools meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
	cdistro_desktop
	cdistro_CLDX
"

RDEPEND="${RDEPEND}
	cdistro_desktop? (
		dev-util/strace
	)
	cdistro_CLDX? (
		x11-terms/rxvt-unicode
	)
"
