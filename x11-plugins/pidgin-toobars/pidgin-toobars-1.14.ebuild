# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

DESCRIPTION="Add toolbar, status bar, context menu to Pidgin buddy list, hide main menu, change all status by menu (not through Statusbox!) and much more."
HOMEPAGE="http://vayurik.ru/wordpress/toobars"
SRC_URI="http://vayurik.ru/wordpress/wp-content/uploads/toobars/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=net-im/pidgin-2.8"

