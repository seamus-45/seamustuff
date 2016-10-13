# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils gnome2-utils

DESCRIPTION="An adaptive Gtk+ theme based on Material Design Guidelines"
HOMEPAGE="https://github.com/adapta-project"

SRC_URI="https://github.com/tista500/Adapta/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

IUSE="cinnamon flashback unity xfce mate openbox chrome plank +custom_palette"

DEPEND="media-gfx/inkscape
	sys-process/parallel
	>=dev-ruby/sass-3.4.21[ruby_targets_ruby21]
	>=dev-ruby/bundler-1.9.10[ruby_targets_ruby21]
"
RDEPEND="x11-themes/gtk-engines-murrine"

S="${WORKDIR}"/Adapta-"${PV}"

src_prepare() {
	export BUNDLE_PATH="${S}/ruby-bundle"
	bundle install
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable cinnamon)
		$(use_enable flashback)
		$(use_enable unity)
		$(use_enable xfce)
		$(use_enable mate)
		$(use_enable openbox)
		$(use_enable chrome)
		$(use_enable plank)
		--enable-parallel
	)
	use custom_palette && myeconfargs=(
		${myeconfargs[@]}
		--with-selection_color=#ff5722
		--with-second_selection_color=#ff8a65
		--with-accent_color=#ff8a65
		--with-suggestion_color=#ff5722
		--with-destruction_color=#d50000
	)
	econf "${myeconfargs[@]}"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
