# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit gnome2-utils

DESCRIPTION="Numix is a modern flat theme with a combination of light and dark elements."
HOMEPAGE="https://github.com/numixproject/numix-gtk-theme"

SRC_URI="https://github.com/numixproject/numix-gtk-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-ruby/sass"
RDEPEND="x11-themes/gtk-engines-murrine"

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
