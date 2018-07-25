# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit scons-utils eutils toolchain-funcs multilib git-r3

DESCRIPTION="A speech synthesizer for Russian (and similar) language"
HOMEPAGE="https://github.com/Olga-Yakovleva/RHVoice"
EGIT_REPO_URI="https://github.com/Olga-Yakovleva/RHVoice"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-lang/python
	app-accessibility/flite
	dev-libs/libunistring
	dev-libs/expat
	dev-libs/libpcre
	media-sound/sox
	dev-util/scons
"

DOCS=(README)

# TODO: multilib support (just in case)

src_compile() {
	escons prefix=/usr sysconfdir=/etc libdir=/usr/$(get_libdir)
}

src_install() {
	# Dirty hack, since it fails to install with multijob
	SCONSOPTS=""
	escons DESTDIR="${D}" prefix=/usr sysconfdir=/etc libdir=/usr/$(get_libdir) install
	einstalldocs
}
