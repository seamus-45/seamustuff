# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

DESCRIPTION="A Simple and Fast Image Viewer for X"
HOMEPAGE="http://www.tuxarena.com/intro/neonview.php"
SRC_URI="http://www.tuxarena.com/intro/files/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc x86 ~arm-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-3.0:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}/${P}-src"

src_install() {
	dodoc BUGS.txt
	dodoc COPYING
	dodoc ChangeLog
	dodoc faq.html
	dodoc features.html
	dobin neonview
	make_desktop_entry neonview "Neon View" "emblem-photos" "Graphics;" || die "Failed making desktop entry!"
}
