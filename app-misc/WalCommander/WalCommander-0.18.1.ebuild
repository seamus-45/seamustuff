# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

DESCRIPTION="Multi-platform open source file manager, mimicking the look-n-feel of Far Manager."
HOMEPAGE="https://github.com/corporateshark/WalCommander"
SRC_URI="https://codeload.github.com/corporateshark/${PN}/tar.gz/release-${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
x11-libs/libX11
media-libs/freetype
net-libs/libssh2
net-fs/samba"
DEPEND="${RDEPEND}
  >=dev-util/cmake-2.8.10
  >=sys-devel/gcc-4.7.0
"

S="${WORKDIR}/${PN}-release-${PV}"

