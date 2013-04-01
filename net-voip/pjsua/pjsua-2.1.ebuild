# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="pjsua is an open source command line SIP user agent"
HOMEPAGE="http://www.pjsip.org/pjsua.htm"
SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 portaudio ssl"

DEPEND="media-libs/speex
	portaudio? ( media-libs/portaudio )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}.0"

src_configure() {
	local localconf

	localconf='--with-external-speex '
	use portaudio && \
		localconf="${localconf} --with-external-pa"
	use portaudio || \
		localconf="${localconf} --without-pa"
	use ssl || \
		localconf="${localconf} --disable-ssl"

	econf ${localconf} || die
}

src_compile() {
	#fails on parallel build
	emake -j1 || die "Make failed!"
}

src_install() {
	exeinto /usr/bin
	newexe pjsip-apps/bin/pjsua* pjsua
}
