# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-1.0.9.ebuild,v 1.1 2014/05/28 19:13:02 ssuominen Exp $

EAPI=5
inherit fdo-mime autotools eutils git-r3 gnome2-utils

DESCRIPTION="A GTK+ interface for MPV"
HOMEPAGE="https://github.com/gnome-mpv/gnome-mpv/"
EGIT_REPO_URI="https://github.com/gnome-mpv/gnome-mpv.git"

if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT=v${PV}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

COMMON_DEPEND=">=dev-libs/glib-2.44
	>=x11-libs/gtk+-3.18:3
	x11-libs/libX11
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
	>=media-video/mpv-0.21[libmpv]
"
DEPEND="${COMMON_DEPEND}
	dev-libs/appstream-glib
"

DOCS="README.md"

src_prepare() {
	sed -i '/$(UPDATE_DESKTOP)/d' Makefile.am || die
	sed -i '/$(UPDATE_ICON)/d' Makefile.am || die
	sed -i '/install-data-hook:/d' Makefile.am || die
	sed -i '/uninstall-hook:/d' Makefile.am || die
	mkdir m4
	eautoreconf
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
