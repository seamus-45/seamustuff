# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (network meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop cdistro_CLDX"

#net-misc/pino
RDEPEND="
	net-misc/whois

	cdistro_desktop? (
		app-text/wgetpaste
		net-analyzer/nmap
		net-analyzer/fping
		net-analyzer/vnstat
		net-im/skype
		www-client/chromium
		www-apps/chromium-adblock
		www-plugins/adobe-flash
	)
	cdistro_CLDX? (
		!net-fs/fusesmb
		net-ftp/filezilla
		net-news/liferea
		mail-client/claws-mail
		mail-client/claws-mail-address_keeper
		mail-client/claws-mail-fancy
		x11-themes/claws-mail-theme-calculate
		net-fs/smbnetfs
		net-im/pidgin
		net-irc/xchat
		net-misc/remmina
		net-misc/vino
		net-p2p/deluge
		x11-plugins/pidgin-hotkeys
		x11-plugins/pidgin-toobars
		x11-plugins/pidgin-libnotify
		x11-plugins/purple-plugin_pack
	)
"

