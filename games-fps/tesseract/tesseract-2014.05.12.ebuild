# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils flag-o-matic gnome2-utils games

EDITION="first_edition"
DESCRIPTION="Tesseract is a first-person shooter game focused on instagib deathmatch and capture-the-flag gameplay as well as cooperative in-game map editing. Tesseract provides a unique open-source engine derived from Cube 2: Sauerbraten technology but with upgraded modern rendering techniques."
HOMEPAGE="http://tesseract.gg/"
SRC_URI="http://download.tuxfamily.org/tesseract/tesseract_${PV//./_}_${EDITION}_linux.tar.xz"

LICENSE="ZLIB freedist"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="server dedicated"

RDEPEND="
	sys-libs/zlib
	!dedicated? (
		media-libs/libsdl2[X,opengl]
		media-libs/sdl2-mixer[vorbis]
		media-libs/sdl2-image[png,jpeg]
		virtual/opengl
		virtual/glu
		x11-libs/libX11 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	ecvs_clean
	rm -rf tesseract_unix bin_unix src/{include,lib,vcpp} screenshot
}

src_compile() {
	emake -C src master $(usex dedicated "server" "$(usex server "server client" "client")")
}

src_install() {
	local LIBEXECDIR="${GAMES_PREFIX}/lib"
	local DATADIR="${GAMES_DATADIR}/${PN}"
	local STATEDIR="${GAMES_STATEDIR}/${PN}"

	if ! use dedicated ; then
		# Install the game data
		insinto "${DATADIR}"
		doins -r media config

		# Install the client executable
		exeinto "${LIBEXECDIR}"
		doexe src/tess_client

		# Install the client wrapper
		games_make_wrapper "${PN}-client" "${LIBEXECDIR}/tess_client -u\$HOME/.${PN} -k" "${DATADIR}"

		# Create menu entry
		newicon -s 256 media/interface/cube.png ${PN}.png
		make_desktop_entry "${PN}-client" "Tesseract"
	fi
	
	if use server || use dedicated; then
		# Install the server config files
		insinto "${STATEDIR}"
		doins "config/server-init.cfg"

		# Install the server executables
		exeinto "${LIBEXECDIR}"
		doexe src/tess_master
		doexe src/tess_server

		games_make_wrapper "${PN}-server" \
			"${LIBEXECDIR}/tess_server -k${DATADIR} -u${STATEDIR}"
		games_make_wrapper "${PN}-master" \
			"${LIBEXECDIR}/tess_master ${STATEDIR}"

		# Install the server init script
		keepdir "${GAMES_STATEDIR}/run/${PN}"
		cp "${FILESDIR}"/${PN}.init "${T}" || die
		sed -i \
			-e "s:%SYSCONFDIR%:${STATEDIR}:g" \
			-e "s:%LIBEXECDIR%:${LIBEXECDIR}:g" \
			-e "s:%GAMES_STATEDIR%:${GAMES_STATEDIR}:g" \
			"${T}"/${PN}.init || die
		newinitd "${T}"/${PN}.init ${PN}
		cp "${FILESDIR}"/${PN}.conf "${T}" || die
		sed -i \
			-e "s:%SYSCONFDIR%:${STATEDIR}:g" \
			-e "s:%LIBEXECDIR%:${LIBEXECDIR}:g" \
			-e "s:%GAMES_USER_DED%:${GAMES_USER_DED}:g" \
			-e "s:%GAMES_GROUP%:${GAMES_GROUP}:g" \
			"${T}"/${PN}.conf || die
		newconfd "${T}"/${PN}.conf ${PN}
	fi

	nonfatal dodoc src/*.txt docs/dev/*.txt README

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
