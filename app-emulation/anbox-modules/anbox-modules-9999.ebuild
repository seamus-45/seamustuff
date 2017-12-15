# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-mod

DESCRIPTION="Required kernel modules for Anbox"
HOMEPAGE="https://anbox.io/"
EGIT_REPO_URI="https://github.com/anbox/anbox.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${P}/kernel"

src_prepare() {
	sed -i 's:, NAME="%k"::g' 99-anbox.rules
	default
}

src_configure() {
	MODULE_NAMES="ashmem_linux(virt:${S}/ashmem) binder_linux(virt:${S}/binder)"
	BUILD_PARAMS='KERNELDIR="${KERNEL_DIR}"'
	BUILD_TARGETS="all"
}

src_install() {
	linux-mod_src_install
	insinto /etc/modules-load.d/
	doins anbox.conf
	insinto /lib/udev/rules.d/
	doins 99-anbox.rules
}
