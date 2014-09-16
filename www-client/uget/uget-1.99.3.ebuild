# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uget/uget-9999.ebuild,v 1.9 2014/05/08 03:05:13 wired Exp $

EAPI="5"

inherit autotools eutils

LANGUAGES="linguas_ar linguas_be linguas_bn_BD linguas_cs linguas_da linguas_de
	linguas_es linguas_fr linguas_hu linguas_id linguas_it linguas_ka_GE linguas_pl
	linguas_pt_BR linguas_ru linguas_tr linguas_uk linguas_vi linguas_zh_CN
	linguas_zh_TW"

IUSE="ssl gnutls gstreamer libnotify nls ayatana ${LANGUAGES}"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	KEYWORDS=""
	SRC_URI=""
	EGIT_PROJECT="urlget-uget2"
	EGIT_REPO_URI="git://git.code.sf.net/p/urlget/uget2"
else
	KEYWORDS="~amd64 ~arm ~ppc ~x86"
	SRC_URI="mirror://sourceforge/urlget/${P}.tar.gz"
fi

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://www.ugetdm.com"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	dev-libs/libpcre
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3.4:3
	>=net-misc/curl-7.10
	ssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls dev-libs/libgcrypt )
	gstreamer? ( media-libs/gstreamer:0.10 )
	libnotify? ( x11-libs/libnotify )
	ayatana? ( dev-libs/libappindicator:3 )
	"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		intltoolize || die "intltoolize failed"
		eautoreconf
	fi
}

src_configure() {
	econf $(use_enable nls) \
		  $(use_with gnutls) \
		  $(use_with ssl openssl) \
		  $(use_enable gstreamer) \
		  $(use_enable libnotify notify) \
		  $(use_enable ayatana appindicator)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install

	if [[ ${PV} == *9999* ]]; then
		dodoc AUTHORS ChangeLog README
	else
		dodoc AUTHORS ChangeLog NEWS README
	fi
}

