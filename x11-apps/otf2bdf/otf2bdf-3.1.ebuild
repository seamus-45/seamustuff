# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="OpenType to BDF Converter"
HOMEPAGE="http://sofia.nmsu.edu/~mleisher/Software/otf2bdf/"
SRC_URI="http://sofia.nmsu.edu/~mleisher/Software/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"

src_install() {
	dobin otf2bdf
	newman otf2bdf.man otf2bdf.1
	dodoc README
}
