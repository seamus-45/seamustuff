# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Generic library for real-time communications with async IO support."
HOMEPAGE="https://github.com/creytiv/re"
SRC_URI="https://github.com/creytiv/re/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	QA_SONAME="/usr/$(get_libdir)/libre.so"
}

src_compile() {
	emake RELEASE=1 LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install
}
