# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="id3 mass tagger is a tool for manipulating id3 and id3v2 tags in multiple files."
HOMEPAGE="https://squell.github.io/id3/"
SRC_URI="https://github.com/squell/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's@^mandir.*$@mandir\t = $(prefix)/share/man@' ${S}/makefile
	default
}

src_install() {
	emake prefix="${D}/usr" install || die "installation failed"
	dodoc CHANGES COPYING README
}
