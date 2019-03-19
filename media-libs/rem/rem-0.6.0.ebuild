# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Audio and video processing media library"
HOMEPAGE="https://github.com/creytiv/rem"
SRC_URI="https://github.com/creytiv/rem/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-voip/re"
RDEPEND="${DEPEND}"

pkg_setup() {
	QA_SONAME="/usr/$(get_libdir)/librem.so"
}

src_compile() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install
}
