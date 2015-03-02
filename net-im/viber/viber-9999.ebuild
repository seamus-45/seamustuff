# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere!"
HOMEPAGE="http://www.viber.com"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	mkdir ${P}
}

src_prepare(){
	tar -xf "${WORKDIR}/data.tar.gz" -C "${S}"	
}

src_install(){
	doins -r "${S}"/*
	fperms 755 /opt/${PN}/Viber
}

pkg_prerm(){
	[[ -e "${ROOT}opt/${PN}/launcher.db" ]] && rm -rf "${ROOT}opt/${PN}/launcher.db"
}
