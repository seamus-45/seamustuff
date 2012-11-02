# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (printer/scanner meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Developer
RDEPEND="
	media-gfx/xsane
	net-print/cndrvcups-capt
	net-print/cnijfilter
	net-print/cups
	net-print/foo2zjs
	net-print/gutenprint
	net-print/hplip
	net-print/hplip-plugin
	net-print/samsung-unified-linux-driver
	cdistro_CLDX? (
		app-admin/system-config-printer-common
	)
"

