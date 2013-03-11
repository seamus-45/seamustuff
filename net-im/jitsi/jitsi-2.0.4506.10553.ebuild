# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit java-pkg-2 java-ant-2 eutils multilib prefix

DESCRIPTION="An audio/video SIP VoIP phone and instant messenger written in Java"
HOMEPAGE="http://www.jitsi.org/"
SRC_URI="https://download.jitsi.org/jitsi/src/${PN}-src-${PV}.zip"
# This download comes with 30 Mb of useless jars.
# SVN access is available, but requires an account at java.net.

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="" # FIXME: Should not use ALSA directly, unless USE="alsa", because e.g. PulseAudio could already use and block it.

RDEPEND=">=virtual/jdk-1.6"
DEPEND=">=virtual/jdk-1.6
    dev-java/xalan:0
    dev-java/ant-nodeps:0"

S="${WORKDIR}/${PN}"

EANT_BUILD_TARGET="rebuild"

src_install() {

  # Netbeans bundles
  insinto ${EPREFIX}/usr/$(get_libdir)/jitsi/sc-bundles
  doins sc-bundles/*.jar sc-bundles/os-specific/linux/*.jar

  # Other libraries
  insinto ${EPREFIX}/usr/$(get_libdir)/jitsi/lib
  doins lib/* lib/os-specific/linux/*
  doins -r lib/bundle # Unnecessary?

  # Native libraries
  insinto ${EPREFIX}/usr/$(get_libdir)/jitsi/lib/native
  # WARNING: Foreign binaries!
  if [[ "${ARCH}" = amd64 ]]
    then doins lib/native/linux-64/*
    else doins lib/native/linux/*
    fi
  # Make sure revdep-rebuild doesn’t complain about them.
  echo "SEARCH_DIRS_MASK=\"${EPREFIX}/usr/$(get_libdir)/jitsi/lib/native\"" > 50-"${PN}"
  insinto /etc/revdep-rebuild && doins "50-${PN}"


  # Starter item / icon
  insinto /usr/share/pixmaps
  doins resources/install/debian/jitsi.svg
  make_desktop_entry jitsi Jitsi jitsi "AudioVideo;Network;InstantMessaging;Chat;Telephony;VideoConference;Java;"

  # Generate man page from template
  sed -e 's/_PACKAGE_NAME_/jitsi/g' -e 's/_APP_NAME_/Jitsi/g' \
    resources/install/debian/jitsi.1.tmpl > jitsi.1 || die
  doman jitsi.1

  # Install custom runscript
  dobin "${FILESDIR}/jitsi" || die

}

