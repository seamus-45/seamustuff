# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Portable and modular SIP User-Agent with audio and video support."
HOMEPAGE="http://www.creytiv.com/baresip.html"
SRC_URI="https://github.com/alfredh/baresip/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"

DEPEND="net-voip/re
	media-libs/rem
	!libressl? ( >=dev-libs/openssl-1.0.1 )
	libressl? ( >=dev-libs/libressl-2.0.0 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch ${FILESDIR}/${PV}-fix-subscribe-topic.patch
	epatch ${FILESDIR}/${PV}-disable-unique-aor.patch
	default
}

src_compile() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install
}
