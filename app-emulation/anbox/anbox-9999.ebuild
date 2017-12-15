# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils git-r3

DESCRIPTION="Anbox is a container-based approach to boot a full Android system on a regular GNU/Linux system"
HOMEPAGE="https://anbox.io/"
EGIT_REPO_URI="https://github.com/anbox/anbox.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/dbus
	sys-libs/libcap
	dev-libs/boost
	dev-libs/dbus-cpp
	dev-libs/glib
	dev-libs/protobuf
	media-libs/libsdl2
	media-libs/mesa[egl,gles2]
	media-libs/sdl2-image
	app-emulation/lxc
	app-emulation/anbox-modules
	app-emulation/anbox-image
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/add_subdirectory(tests)/d' CMakeLists.txt
	sed -i '/find_package(GMock)/d' CMakeLists.txt
	cmake-utils_src_prepare
}

src_install() {
	insinto /usr/share/pixmaps/
	newins snap/gui/icon.png "${PN}".png
	insinto /usr/share/applications/
	doins "${FILESDIR}"/"${PN}".desktop
	newconfd "${FILESDIR}"/anbox-bridge.confd anbox-bridge
	newinitd "${FILESDIR}"/anbox-bridge.initd anbox-bridge
	cmake-utils_src_install
}

pkg_postinst() {
	elog "You should add 'anbox' to the default runlevel."
	elog "e.g. rc-update add anbox default"
}
