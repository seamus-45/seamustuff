# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

DESCRIPTION="${PN} - Bash script for select and install 2gis shell/data"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=gnome-extra/zenity-2.32.1
		app-arch/unzip
		net-misc/wget
		app-emulation/wine"

S="${WORKDIR}"

src_install() {
	insopts -m0644
	insinto /usr/share/applications/
	doins "${FILESDIR}/2gis.desktop"
	doins "${FILESDIR}/2gis-update.desktop"
	insinto /usr/share/pixmaps/
	doins "${FILESDIR}/2gis.png"
	insopts -m0755
	exeinto /usr/bin
	doexe "${FILESDIR}/2gis-update.sh"
	default
}
