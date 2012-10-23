# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Taxi Version (office meta package)"
HOMEPAGE="http://taximaxim.ru"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLDX linguas_en linguas_ru"

RDEPEND="
	app-editors/vim
	app-office/libreoffice
	app-text/fbreader

	cdistro_CLDX? (
		!app-editors/mousepad
		app-editors/leafpad
		app-text/evince
		app-text/stardict
		sci-calculators/galculator
	)

	linguas_en? (
		app-dicts/aspell-en
		app-dicts/myspell-en
	)
	linguas_ru? (
		app-dicts/aspell-ru
		!app-dicts/ispell-ru
		app-dicts/myspell-ru
	)
"

