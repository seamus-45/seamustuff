# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (XFCE meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${RDEPEND}
	!xfce-extra/thunar-thumbnailers
"

RDEPEND="${RDEPEND}
	app-arch/xarchiver
	xfce-base/xfce4-meta
	xfce-extra/thunar-archive-plugin
	xfce-extra/thunar-volman
	xfce-extra/tumbler
	xfce-extra/xfce4-battery-plugin
	xfce-extra/xfce4-clipman-plugin
	xfce-extra/xfce4-cpugraph-plugin
	xfce-extra/xfce4-datetime-plugin
	xfce-extra/xfce4-gvfs-mount
	xfce-extra/xfce4-mailwatch-plugin
	xfce-extra/xfce4-mixer
	xfce-extra/xfce4-netload-plugin
	xfce-extra/xfce4-notes-plugin
	xfce-extra/xfce4-notifyd
	xfce-extra/xfce4-power-manager
	xfce-extra/xfce4-screenshooter
	xfce-extra/xfce4-taskmanager
	xfce-extra/xfce4-quicklauncher-plugin
	xfce-extra/xfce4-xkb-plugin
"

