# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.18"

inherit eutils gnome2 vala

DESCRIPTION="Library providing a virtual terminal emulator widget"
HOMEPAGE="https://wiki.gnome.org/action/show/Apps/Terminal/VTE"

LICENSE="LGPL-2+"
SLOT="2.91"
IUSE="debug glade +introspection vala termite-patch"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 x86-fbsd x86-freebsd x86-interix amd64-linux arm-linux x86-linux x64-solaris x86-solaris"

PDEPEND=">=x11-libs/gnome-pty-helper-${PV}"
RDEPEND="
	>=dev-libs/glib-2.40:2
	>=x11-libs/gtk+-3.8:3[introspection?]
	>=x11-libs/pango-1.22.0

	sys-libs/ncurses
	x11-libs/libX11
	x11-libs/libXft

	glade? ( >=dev-util/glade-3.9:3.10 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )
"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/gtk-doc-am-1.13
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	use termite-patch && epatch "${FILESDIR}"/${PN}-0.38.1-expose_select_text.patch
	gnome2_src_prepare
}

src_configure() {
	local myconf=""

	if [[ ${CHOST} == *-interix* ]]; then
		myconf="${myconf} --disable-Bsymbolic"

		# interix stropts.h is empty...
		export ac_cv_header_stropts_h=no
	fi

	# Python bindings are via gobject-introspection
	# Ex: from gi.repository import Vte
	# Do not disable gnome-pty-helper, bug #401389
	gnome2_src_configure \
		--disable-deprecation \
		--disable-test-application \
		--disable-static \
		$(use_enable debug) \
		$(use_enable glade glade-catalogue) \
		$(use_enable introspection) \
		$(use_enable vala) \
		${myconf}
}

src_install() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
	gnome2_src_install
	mv "${D}"/etc/profile.d/vte{,-${SLOT}}.sh || die
}
