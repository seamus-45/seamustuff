# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils scons-utils

DESCRIPTION="Goxel: Free and Open Source 3D Voxel Editor"
HOMEPAGE="https://guillaumechereau.github.io/goxel"
SRC_URI="https://github.com/guillaumechereau/goxel/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-util/scons-2.3.0"
RDEPEND="${DEPEND}
	>=media-libs/glfw-3.0.0
	x11-libs/gtk+:3
"

src_prepare() {
	default

	sed -i 's@${SNAP}/icon.png@goxel@' ${S}/snap/gui/goxel.desktop
	sed -i 's@install -Dm744 goxel@install -Dm0755 goxel@' ${S}/Makefile
}

src_compile() {
	escons debug=$(usex debug 1 0)
	emake release
}

src_install() {
	emake PREFIX="${ED}"/usr install
}
