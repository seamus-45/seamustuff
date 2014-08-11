# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"
SRC_URI="https://github.com/strophe/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc xml"

RDEPEND="xml? ( dev-libs/libxml2 )
		!xml? ( dev-libs/expat )
		dev-libs/openssl"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

src_prepare() {
		eautoreconf
}

src_configure() {
		econf $(use_with xml libxml2)
}

src_compile() {
		emake
		if use doc; then
			doxygen || die
		fi
}

src_install() {
		einstall
		dodoc LICENSE.txt README.markdown
		use doc && dohtml -r docs/html/*
}
