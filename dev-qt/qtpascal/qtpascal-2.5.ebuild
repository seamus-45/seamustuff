# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2

DESCRIPTION="selective bind Qt to free pascal"
HOMEPAGE="http://users.telenet.be/Jan.Van.hijfte/qtforfpc/fpcqt4.html"
FULL_VERSION="qt4pas-V2.5_Qt4.5.3"
SRC_URI="http://users.telenet.be/Jan.Van.hijfte/qtforfpc/V2.5/${FULL_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="4"

KEYWORDS="~x86 ~amd64"

DEPEND=" dev-qt/qtcore
	 dev-qt/qtwebkit
	 dev-qt/qtgui
"

src_unpack(){
	unpack "${A}"
	cd "${WORKDIR}"
	mv "${FULL_VERSION}" "${PF}"
}

src_prepare(){
	eqmake4 Qt4Pas.pro
}
