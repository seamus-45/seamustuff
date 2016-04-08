# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-2

EGIT_REPO_URI="git://github.com/boothj5/profanity.git"
EGIT_BRANCH="master"

DESCRIPTION="Ncurses based jabber client inspired by irssi"
HOMEPAGE="http://www.profanity.im/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="libnotify pgp otr +themes xml xscreensaver +c-plugins python-plugins"

RDEPEND="dev-libs/glib:2
	>=dev-libs/libstrophe-0.8-r1[xml=]
	net-misc/curl
	sys-libs/ncurses
	pgp? ( app-crypt/gpgme )
	otr? ( net-libs/libotr )
	xscreensaver? ( x11-libs/libXScrnSaver )
	libnotify? ( 
	  virtual/notification-daemon
	  x11-libs/libnotify 
	)
	python-plugins? ( dev-lang/python:2.7 )
	"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable libnotify notifications) \
		$(use_enable pgp) \
		$(use_enable otr) \
		$(use_with themes) \
		$(use_with xscreensaver) \
		$(use_with c-plugins) \
		$(use_with python-plugins)

}

pkg_postinst() {
	elog "Profanity user guide available online at the following link:"
	elog "http://www.profanity.im/userguide.html"
}
