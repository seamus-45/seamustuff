# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils qt4-r2 multilib git-2 gnome2-utils

DESCRIPTION="The new multimedia player(based on SMPlayer) with clean and elegant UI."
HOMEPAGE="http://www.rosalab.ru/"
EGIT_REPO_URI="https://abf.rosalinux.ru/uxteam/ROSA_Media_Player.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin ffmpeg"
LANGS="ar bg ca cs de el en_GB es_LA es et eu fi fr gl hu it ja ka ko ku lt mk nl pl pt_PT pt pt_BR ro ru sk sl sr sv tr uk vi zh_CN zh_TW"
for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

RDEPEND="media-video/mplayer
	nsplugin? ( www-plugins/rosa-media-player-plugin )
	ffmpeg? ( virtual/ffmpeg )
	net-misc/wget
"
DEPEND="${RDEPEND}
	dev-libs/glib
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtmultimedia:4
	media-sound/wildmidi
	dev-libs/qjson
"
S="${WORKDIR}/${PN}"

src_compile() {
	cd ${PN}
	sed -i '1i#define OF(x) x' \
		src/findsubtitles/quazip/ioapi.{c,h} \
		src/findsubtitles/quazip/{zip,unzip}.h || die

	emake PREFIX=/usr || die
}

src_install() {
	cd ${PN}
	for lang in ${LANGS};do
		if ! use linguas_${lang}; then
			rm -f "$(find src/translations -type f -name "rosamp_${lang}*.qm")"
			rm -rf docs/${lang}
		fi
	done
	emake PREFIX=/usr DESTDIR="${D}" install || die
}

pkg_postinst() {
	gnome2_icon_cache_update
}

