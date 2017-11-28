# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Ncurses based jabber client inspired by irssi"
HOMEPAGE="http://www.profanity.im/"
EGIT_REPO_URI="git://github.com/boothj5/profanity.git"

KEYWORDS="~amd64 ~x86"
if [[ $PV != 9999 ]]; then
	EGIT_COMMIT=$PV
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="libnotify pgp otr +themes xml xscreensaver +c-plugins python-plugins icons"

RDEPEND=">=dev-libs/glib-2.26:2
	|| (
		dev-libs/libmesode
		>=dev-libs/libstrophe-0.8.9
	)
	net-misc/curl
	sys-libs/readline
	sys-libs/ncurses
	pgp? ( app-crypt/gpgme )
	otr? ( net-libs/libotr )
	xscreensaver? ( x11-libs/libXScrnSaver )
	libnotify? ( x11-libs/libnotify )
	python-plugins? ( dev-lang/python:2.7 )
	"

DEPEND="${RDEPEND}
	sys-devel/autoconf-archive"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		PYTHON_VERSION='2.7' \
		$(use_enable libnotify notifications) \
		$(use_enable pgp) \
		$(use_enable otr) \
		$(use_enable c-plugins) \
		$(use_enable python-plugins) \
		$(use_enable icons) \
		$(use_with themes) \
		$(use_with xscreensaver)
}

pkg_postinst() {
	elog "Profanity user guide available online at the following link:"
	elog "http://www.profanity.im/userguide.html"
}