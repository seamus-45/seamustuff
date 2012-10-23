# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (multimedia meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLDX"

RDEPEND="
	media-gfx/scrot
	media-sound/alsa-utils
	media-sound/sox
	media-video/mplayer
	cdistro_CLDX? (
		app-cdr/xfburn
		media-sound/audacious
		media-video/gnome-mplayer
	)

"

