# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="MintMenu supports filtering, favorites, easy-uninstallation, autosession, and many other features."
SRC_URI="http://packages.linuxmint.com/pool/main/m/mintmenu/${PN}_${PV}.tar.gz"
MINT_TRANSLATIONS="mint-translations_2013.11.26.tar.gz"
LANG_URL="http://packages.linuxmint.com/pool/main/m/mint-translations/${MINT_TRANSLATIONS}"
HOMEPAGE="http://linuxmint.com"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="terminal"

LANGS="af am ar ast be ber bg bn bs ca ckb csb cs cy da de el en_AU en_CA en_GB eo es et eu fa fi fo fr gl gv"
LANGS="${LANGS} he hi hr hu hy id is it ja jv kk kn ko lt lv mk ml mr ms nb nds nl nn oc pa pl pt_BR pt ro ru"
LANGS="${LANGS} si sk sl sq sr sv ta te th tr uk ur vi zh_CN zh_HK zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
	SRC_URI="${SRC_URI} linguas_${X}? ( ${LANG_URL} )"
done

RDEPEND=">=dev-lang/python-2.4.6
	<dev-lang/python-3.1.1-r1
	dev-python/pygtk
	dev-python/pyxdg
	mate-base/mate-panel
	dev-python/python-xlib"

DEPEND="${RDEPEND}
	sys-apps/sed"

S="${WORKDIR}"

src_install() {
	dobin mintmenu/usr/bin/mintmenu
	dodir /usr/lib/linuxmint/mintMenu
	insinto /usr/lib/linuxmint/mintMenu
	cp -R mintmenu/usr/lib/linuxmint/mintMenu/* ${D}usr/lib/linuxmint/mintMenu
	dodir /usr/share/
	insinto /usr/share/
	cp -R mintmenu/usr/share/* ${D}/usr/share

	[[ -f ${MINT_TRANSLATIONS} ]] && unpack ${MINT_TRANSLATIONS}
	for X in ${LANGS} ; do
	  if use linguas_${X}; then
	    dodir /usr/share/linuxmint/locale/${X}/LC_MESSAGES
	    insinto /usr/share/linuxmint/locale/${X}/LC_MESSAGES
	    doins mint-translations*/usr/share/linuxmint/locale/${X}/LC_MESSAGES/mintmenu.mo
	  fi
	done
}

pkg_postinst() {
	ebegin "Recompiling glib schemas"
	  glib-compile-schemas /usr/share/glib-2.0/schemas/
	eend $?
}

