# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

MY_PV=${PV//./\/}

DESCRIPTION="Android image for using with anbox"
HOMEPAGE="https://source.android.com"
SRC_URI="https://build.anbox.io/android-images/${MY_PV}/android_1_arm64.img"

LICENSE="Apache 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${DISTDIR}"

src_unpack() {
	# skip unpack
	:
}

src_install() {
	insinto /var/lib/anbox/
	newins android_1_arm64.img android.img
}
