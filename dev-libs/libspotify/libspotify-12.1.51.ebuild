# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="SDK/C language API for Spotify"
HOMEPAGE="https://mopidy.github.io/libspotify-archive/"
SRC_URI="x86? ( ${HOMEPAGE}/${P}-Linux-i686-release.tar.gz -> ${P}.tar.gz )
	amd64? ( ${HOMEPAGE}/${P}-Linux-x86_64-release.tar.gz -> ${P}.tar.gz  )
"

LICENSE="libspotify Boost-1.0 MIT BSD ZLIB CPOL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

QA_PRESTRIPPED="/usr/lib*/${PN}.so.${PV}"
QA_PREBUILD="${QA_PRESTRIPPED}"

S="${WORKDIR}"

src_unpack() {
	# manually unpack and cut first path component
	tar -C "${S}" -x --strip-components 1 \
		-f "${DISTDIR}/${P}.tar.gz"
}

src_prepare() {
	default
	sed -i -e "s|PKG_PREFIX|${EROOT}/usr|" \
		-e "s|/lib|/$(get_libdir)|" \
		lib/pkgconfig/libspotify.pc || die
}

src_compile() { :; }

src_install() {
	dolib.so lib/${PN}.so.${PV}
	dosym ${PN}.so.${PV} /usr/$(get_libdir)/${PN}.so.${PV%%.*}
	dosym ${PN}.so.${PV} /usr/$(get_libdir)/${PN}.so

	insinto /usr/$(get_libdir)/pkgconfig
	doins lib/pkgconfig/libspotify.pc

	insinto /usr/include/${PN}
	doins include/libspotify/api.h

	doman share/man*/*
	dodoc README LICENSE ChangeLog

	if use doc ; then
		dodoc -r share/doc/libspotify/examples/
		dohtml -r share/doc/libspotify/html/*
	fi
}
