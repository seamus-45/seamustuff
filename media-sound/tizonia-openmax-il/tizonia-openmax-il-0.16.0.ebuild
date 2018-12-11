# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
inherit eutils autotools python-single-r1

DESCRIPTION="Command-line cloud music player for Linux with support for Spotify, Google Play Music, YouTube, SoundCloud, Dirble, Plex servers and Chromecast devices."
HOMEPAGE="http://tizonia.org/"
SRC_URI="https://github.com/tizonia/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +aac +cli +spotify "

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-libs/boost:=[python,${PYTHON_USEDEP}]
	dev-libs/check
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	aac? ( media-libs/faad2 )
	alsa? ( media-libs/alsa-lib )
	dev-db/sqlite
	dev-libs/log4c
	dev-python/eventlet[${PYTHON_USEDEP}]
	dev-python/fuzzywuzzy[${PYTHON_USEDEP}]
	dev-python/gmusicapi[${PYTHON_USEDEP}]
	dev-python/pafy[${PYTHON_USEDEP}]
	dev-python/plexapi[${PYTHON_USEDEP}]
	dev-python/pychromecast[${PYTHON_USEDEP}]
	dev-python/soundcloud-python[${PYTHON_USEDEP}]
	dev-python/spotipy[${PYTHON_USEDEP}]
	media-libs/flac
	media-libs/libfishsound
	media-libs/libmad
	media-libs/libogg
	media-libs/liboggz
	media-libs/libsdl
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/libvpx
	media-libs/opus
	media-libs/opusfile
	media-libs/taglib
	media-sound/lame
	media-sound/mpg123
	media-sound/pulseaudio
	media-video/mediainfo
	net-misc/curl[curl_ssl_openssl]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
	spotify? ( media-sound/spotify )
	sys-apps/util-linux
"

src_prepare() {
	local files=(
		clients/spotify/libtizspotify/src/Makefile.am
		clients/spotify/libtizspotify/libtizspotify.pc.in
		clients/plex/libtizplex/src/Makefile.am
		clients/plex/libtizplex/libtizplex.pc.in
		clients/youtube/libtizyoutube/src/Makefile.am
		clients/youtube/libtizyoutube/libtizyoutube.pc.in
		clients/chromecast/libtizchromecast/src/Makefile.am
		clients/chromecast/libtizchromecast/libtizchromecast.pc.in
		clients/dirble/libtizdirble/src/Makefile.am
		clients/dirble/libtizdirble/libtizdirble.pc.in
		clients/gmusic/libtizgmusic/src/Makefile.am
		clients/gmusic/libtizgmusic/libtizgmusic.pc.in
		clients/soundcloud/libtizsoundcloud/src/Makefile.am
		clients/soundcloud/libtizsoundcloud/libtizsoundcloud.pc.in
	)
	for ff in "${files[@]}"; do
		sed -i -e "s@-lboost_python@\0-${EPYTHON#python}@" ${ff}
	done
	default
	eautoreconf
}

src_configure() {
	econf \
		--silent \
		--enable-silent-rules \
		--disable-static \
		$(use_with alsa) \
		$(use_with aac) \
		$(use_with spotify libspotify) \
		$(use_enable cli player)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake install DESTDIR="${D}" "${EPREFIX}/usr" || die "emake install failed"
}
