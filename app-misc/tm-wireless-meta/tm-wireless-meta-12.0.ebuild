# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (wireless meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop"

# wi-fi
RDEPEND="${RDEPEND}
	!net-wireless/iwl1000-ucode
	!net-wireless/iwl3945-ucode
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode
	!net-wireless/iwl5150-ucode
	!net-wireless/iwl6000-ucode
	!net-wireless/iwl6050-ucode
	!net-wireless/rt73-firmware
	sys-kernel/linux-firmware

	net-wireless/b43-firmware
	net-wireless/bluez-firmware
	net-wireless/broadcom-sta
	net-wireless/ipw2100-firmware
	net-wireless/ipw2200-firmware
	net-wireless/linux-wlan-ng-firmware
	net-wireless/madwifi-ng
	net-wireless/madwifi-ng-tools
	net-wireless/prism54-firmware
	net-wireless/rtl8192su-firmware
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	net-wireless/zd1201-firmware
	net-wireless/zd1211-firmware
"
# wi-max
RDEPEND="${RDEPEND}
	cdistro_desktop? ( net-wireless/madwimax )
"

