# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A modern and lightweight status bar for X window managers"
HOMEPAGE="https://github.com/geommer/yabar"
SRC_URI="https://github.com/geommer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/pango
	>=dev-libs/libconfig-1.4
	x11-libs/xcb-util-wm
	x11-libs/cairo
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"
