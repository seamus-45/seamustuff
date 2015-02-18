# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit gnome2-utils user versionator

DESCRIPTION="Proprietary freeware multimedia map of several Russian and Ukrainian towns"
HOMEPAGE="http://2gis.ru"
MY_P=$(version_format_string '${PN}_$1.$2.$3-0trusty1+shv$4+r$5_amd64.deb')
SRC_URI="http://deb.2gis.ru/pool/non-free/2/2gis/${MY_P} -> ${P}.deb"

SLOT="0"
KEYWORDS="~amd64"
IUSE="bundled-libs"

RDEPEND="
!bundled-libs? (
  >=dev-qt/qtcore-5.2:5
  >=dev-qt/qtgui-5.2:5[jpeg,png,opengl,xcb]
  >=dev-qt/qtnetwork-5.2:5
  >=dev-qt/qtsql-5.2:5
  >=dev-qt/qtwebkit-5.2:5[opengl,printsupport]
)
bundled-libs? (
  media-libs/libpng:1.2
  dev-libs/2gis-icu:0/52
  media-libs/2gis-jpeg
)
"

S="${WORKDIR}"

src_unpack() {
	ar x ${DISTDIR}/${A}
	unpack ./data.tar.xz
	rm -v control.tar.gz data.tar.xz debian-binary
}

pkg_setup() {
	enewgroup gis
}

src_install() {
	if ! use bundled-libs ; then
		rm -rvf ${S}/usr/lib/2GIS/v4/lib/
	fi
	rm -rvf ${S}/var
	insinto /
	doins -r ${S}/*
	fowners root:gis /usr/bin/2gis
	fperms 2755 /usr/bin/2gis
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	test -d "${EROOT}var/cache/2GIS" || {
		mkdir "${EROOT}var/cache/2GIS"
		use prefix || {
			chown root:gis "${EROOT}var/cache/2GIS"
			chmod g+ws "${EROOT}var/cache/2GIS"
		}
	}
	gnome2_icon_cache_update
}

pkg_postrm() {
	[ -n "${REPLACED_BY_VERSION}" ] || rm -rf -- "${EROOT}var/cache/2GIS"
	gnome2_icon_cache_update
}
