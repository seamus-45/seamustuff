# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-info linux-mod

DESCRIPTION="Required kernel modules for Anbox"
HOMEPAGE="https://anbox.io/"
EGIT_REPO_URI="https://github.com/anbox/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/linux-sources"

MODULE_NAMES="ashmem_linux(virt:${S}/ashmem) binder_linux(virt:${S}/binder)"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
	BUILD_TARGETS="all"
}

src_prepare() {
	sed -i 's:, NAME="%k"::g' 99-anbox.rules
	if kernel_is ge 4 14 0; then
		sed -i "s:__vfs_read:kernel_read:" ${S}/ashmem/ashmem.c
	fi

	default
}

src_install() {
	linux-mod_src_install

	insinto /etc/modules-load.d/
	doins anbox.conf
	insinto /lib/udev/rules.d/
	doins 99-anbox.rules
}
