# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="qView is an image viewer designed with minimalism and usability in mind."
HOMEPAGE="https://interversehq.com/qview/"
SRC_URI="https://github.com/jurplel/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtconcurrent:5
	dev-qt/qtimageformats:5
	dev-qt/qtsvg:5
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
	rm ${D}/usr/share/licenses/qview/LICENSE
	rmdir -p ${D}/usr/share/licenses/qview/
	dodoc LICENSE README.md
}
