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
	calculate_noarch
	calculate_nosamba
"

RDEPEND="${RDEPEND}
	!sys-fs/ntfsprogs
	app-editors/nano
	sys-apps/ethtool
	sys-kernel/module-rebuild

	cdistro_desktop? (
		net-misc/dhcpcd
		sys-apps/pcmciautils
		sys-apps/usb_modeswitch

		app-admin/sudo
		dev-python/ipython
		dev-tcltk/expect
		sys-apps/keyexec
		sys-apps/preload
		sys-auth/thinkfinger
		sys-power/acpi
		sys-power/acpid
		sys-power/cpufreqd
		sys-power/powernowd
		sys-power/powertop
		x11-apps/mesa-progs
		x11-apps/xdpyinfo
		x11-apps/xev
		x11-apps/xmessage
		x11-misc/xcalib
		x11-misc/xbindkeys

		app-admin/hddtemp
		app-admin/testdisk
		app-cdr/cdrkit
		app-cdr/dvd+rw-tools
		!calculate_nosamba? ( app-misc/mc )
		app-portage/gentoolkit-dev
		app-portage/portage-utils
		sys-apps/acl
		sys-apps/gptfdisk
		sys-apps/hdparm
		sys-apps/lm_sensors
		sys-apps/memtest86+
		sys-apps/pciutils
		sys-apps/pv
		sys-apps/smartmontools
		sys-apps/xinetd
		sys-devel/prelink
		sys-fs/dmraid
		sys-fs/dosfstools
		sys-fs/e2fsprogs
		sys-fs/jfsutils
		sys-fs/mdadm
		sys-fs/mtools
		sys-fs/ntfs3g
		sys-fs/xfsprogs
		sys-process/htop
		sys-process/lsof
	)
	cdistro_CLDX? (
		net-analyzer/traceroute
		!x11-misc/ktsuss
		sys-block/gparted
		x11-terms/terminal
	)
"

# Archive
RDEPEND="${RDEPEND}
	!calculate_noarch? (
		app-arch/arj
		app-arch/dump
		app-arch/p7zip
		app-arch/rar
		app-arch/unace
		app-arch/unarj
		app-arch/unzip
		app-arch/zip
	)
"

# Base
RDEPEND="${RDEPEND}
	app-admin/logrotate
	app-admin/syslog-ng
	!sys-apps/hotplug
	sys-process/vixie-cron
"

