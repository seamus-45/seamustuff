# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils qt4-r2 multilib git-2

DESCRIPTION="The new multimedia player(based on SMPlayer) with clean and elegant UI (mozilla plugin only)."
HOMEPAGE="http://www.rosalab.ru/"
EGIT_REPO_URI="https://abf.rosalinux.ru/uxteam/rosa-media-player-plugin.git"
EGIT_HAS_SUBMODULES="true"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+rm +wmp +divx"
LANGS="ar bg ca cs de el en_GB es_LA es et eu fi fr gl hu it ja ka ko ku lt mk nl pl pt_PT pt pt_BR ro ru sk sl sr sv tr uk vi zh_CN zh_TW"
for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

RDEPEND="media-video/mplayer"
DEPEND="${RDEPEND}
	dev-libs/glib
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-sound/wildmidi"

S="${WORKDIR}"

src_compile() {
	cd ${S}/romp/rosa-media-player
	qmake
	emake
	cd ${S}
	if ! use 'rm'; then
		sed -i '/.*rosamp-plugin-rm.*/d' rosa-media-player-plugin.pro
	fi

	if ! use 'wmp'; then
		sed -i '/.*rosamp-plugin-wmp.*/d' rosa-media-player-plugin.pro
	fi

	if ! use 'divx'; then
		sed -i '/.*rosamp-plugin-dvx.*/d' rosa-media-player-plugin.pro
	fi
	emake
	lrelease rosa-media-player-plugin.pro
}
src_install() {
	dodir /usr/$(get_libdir)/mozilla/plugins/
	insinto /usr/$(get_libdir)/mozilla/plugins/
	doins rosamp-plugin/build/librosa-media-player-plugin-*.so

	dodir usr/$(get_libdir)/
	dolib romp/rosa-media-player/build/librosampcore.so*

	for lang in ${LANGS};do
	  if ! use linguas_${lang}; then
		rm -f "$(find rosamp-plugin/translations -type f -name "rosamp_plugin_${lang}*.qm")"
	  fi
	done

	for i in $(find translations -type f -name "rosamp_plugin_*.qm");do
	dodir /usr/share/rosa-media-player-plugin/translations/
	insinto /usr/share/rosa-media-player-plugin/translations/
	doins ${i}
	done
}

