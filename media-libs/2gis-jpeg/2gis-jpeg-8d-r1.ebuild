# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-8d-r1.ebuild,v 1.17 2014/06/09 23:22:38 vapier Exp $

EAPI=5
inherit eutils libtool

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format (bundle for 2gis)"
HOMEPAGE="http://jpegclub.org/ http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/jpegsrc.v${PV}.tar.gz
	mirror://debian/pool/main/libj/libjpeg8/libjpeg8_8d-1.debian.tar.gz"

LICENSE="IJG"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/jpeg-8d"

src_prepare() {
	epatch \
		"${FILESDIR}"/jpeg-7-maxmem_sysconf.patch \
		"${FILESDIR}"/jpeg-8d-CVE-2013-6629.patch
	elibtoolize
}

src_configure() {
	ECONF_SOURCE=${S} econf --enable-maxmem=64 
}

src_install() {
	insinto /usr/lib/2GIS/v4/lib/
	doins ${S}/.libs/libjpeg.so*
}
