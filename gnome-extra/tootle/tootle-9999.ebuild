# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vala meson gnome2-utils xdg-utils git-r3

DESCRIPTION="GTK3 client for Mastodon"
HOMEPAGE="https://github.com/bleakgrey/tootle"
EGIT_REPO_URI="https://github.com/bleakgrey/tootle.git"

if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT=${PV}
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

VALA_DEPEND="
	$(vala_depend)
	>=dev-libs/gobject-introspection-1.54
"

RDEPEND="
	>=x11-libs/gtk+-3.16:3
	>=net-libs/libsoup-2.4
	dev-libs/granite
	dev-libs/json-glib
"

DEPEND="${RDEPEND} ${VALA_DEPEND}"

src_prepare() {
	vala_src_prepare
	default
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
