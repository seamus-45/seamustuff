# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION='A programmable binaural-beat generator'
HOMEPAGE="http://gnaural.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/portaudio
	gnome-base/libglade
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	epatch "${FILESDIR}"/gcc-inline.patch
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
