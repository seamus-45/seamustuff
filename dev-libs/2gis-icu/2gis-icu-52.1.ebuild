# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/icu/icu-52.1.ebuild,v 1.14 2014/09/12 00:49:11 jmorgan Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="International Components for Unicode (bundle for 2gis)"
HOMEPAGE="http://www.icu-project.org/"
SRC_URI="http://download.icu-project.org/files/icu4c/${PV/_/}/icu4c-${PV//./_}-src.tgz"

LICENSE="BSD"

SLOT="0/52"

KEYWORDS="~amd64"

S="${WORKDIR}/icu/source"

src_prepare() {
	local variable

	epatch "${FILESDIR}/icu-fix-tests-depending-on-date.patch"
	epatch_user

	# Do not hardcode flags in icu-config and icu-*.pc files.
	# https://ssl.icu-project.org/trac/ticket/6102
	for variable in CFLAGS CPPFLAGS CXXFLAGS FFLAGS LDFLAGS; do
		sed \
			-e "/^${variable} =.*/s: *@${variable}@\( *$\)\?::" \
			-i config/icu.pc.in \
			-i config/Makefile.inc.in \
			|| die
	done

	# Fix linking of icudata
	sed -i \
		-e "s:LDFLAGSICUDT=-nodefaultlibs -nostdlib:LDFLAGSICUDT=:" \
		config/mh-linux || die

	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf "--disable-samples"
}

src_install() {
	insinto /usr/lib/2GIS/v4/lib/
	doins ${S}/lib/libicu*
}
