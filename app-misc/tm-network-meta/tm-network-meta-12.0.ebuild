# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (network tools meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop cdistro_CLDX networkmanager"

RDEPEND="
	net-fs/nfs-utils

	cdistro_desktop? (
		net-dialup/pptpclient
		net-dialup/rp-pppoe
		net-dns/bind-tools
		net-misc/ntp
		net-misc/vconfig
		networkmanager? (
			net-misc/cnetworkmanager
			net-misc/networkmanager
			net-misc/networkmanager-openvpn
			net-misc/networkmanager-pptp
			net-misc/networkmanager-vpnc
		)
	)
	cdistro_CLDX? (
		gnome-extra/nm-applet
	)
"

