# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

DESCRIPTION="${PN} - Bash script for check domain shares availability, mount via
automount and add gtk bookmarks."

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=gnome-extra/zenity-2.32.1
		net-fs/autofs"

S="${WORKDIR}"

src_install() {
	insopts -m0755
	exeinto /usr/bin
	doexe "${FILESDIR}/checkshares.sh"
	default
}
