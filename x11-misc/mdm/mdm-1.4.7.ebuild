# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils pam gnome2 user

DESCRIPTION="Mint Display Manager"
HOMEPAGE="https://github.com/linuxmint/mdm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE_LIBC="elibc_glibc"
IUSE="accessibility afs branding +consolekit dmx ipv6 gnome-keyring pam remote selinux tcpd xinerama $IUSE_LIBC"

# Name of the tarball with gentoo specific files
GDM_EXTRA="gdm-2.20.9-gentoo-files-r1"

SRC_URI="https://github.com/linuxmint/mdm/archive/${PV}.tar.gz
	mirror://gentoo/${GDM_EXTRA}.tar.bz2
	branding? ( mirror://gentoo/gentoo-gdm-theme-r3.tar.bz2 )"

RDEPEND="!=gnome-base/gdm-2*
	>=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.6:2
	>=x11-libs/pango-1.3
	>=gnome-base/libglade-2:2.0
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/librsvg-1.1.1:2
	>=dev-libs/libxml2-2.4.12:2
	>=media-libs/libart_lgpl-2.3.11
	net-libs/webkit-gtk:2
	x11-libs/gksu
	x11-libs/libXi
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXext
	x11-apps/sessreg
	xinerama? ( x11-libs/libXinerama )
	consolekit? (
		sys-auth/consolekit
		dev-libs/dbus-glib )
	accessibility? ( x11-libs/libXevie )
	afs? ( net-fs/openafs sys-libs/lwp )
	dmx? ( x11-libs/libdmx )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.22[pam] )
	pam? ( virtual/pam )
	!pam? ( elibc_glibc? ( sys-apps/shadow ) )
	remote? ( gnome-extra/zenity )
	selinux? ( sys-libs/libselinux )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	>=x11-misc/xdg-utils-1.0.2-r3"
DEPEND="${RDEPEND}
	dmx? ( x11-proto/dmxproto )
	xinerama? ( x11-proto/xineramaproto )
	app-text/docbook-xml-dtd:4.1.2
	sys-devel/gettext
	x11-proto/inputproto
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--with-prefetch
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--with-pam-prefix=/etc
		--disable-static
		SOUND_PROGRAM=/usr/bin/mdmplay
		$(use_enable ipv6)
		$(use_enable remote secureremote)
		$(use_with accessibility xevie)
		$(use_with consolekit console-kit)
		$(use_with dmx)
		$(use_with selinux)
		$(use_with tcpd tcp-wrappers)
		$(use_with xinerama)"

	if use pam; then
		G2CONF="${G2CONF} --enable-authentication-scheme=pam"
	else
		G2CONF="${G2CONF} --enable-console-helper=no"
		if use elibc_glibc ; then
			G2CONF="${G2CONF} --enable-authentication-scheme=shadow"
		else
			G2CONF="${G2CONF} --enable-authentication-scheme=crypt"
		fi
	fi

	enewgroup mdm
	enewuser mdm -1 -1 /var/lib/mdm mdm
}

src_prepare() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi

	gnome2_src_prepare

	# remove unneeded linker directive for selinux (#41022)
	epatch "${FILESDIR}/${PN}-2.13.0.1-selinux-remove-attr.patch"

	# Add gksu to mdmsetup menu entry
	#epatch "${FILESDIR}/${PN}-2.20.2-gksu.patch"

	# Make custom session work, bug #216984
	epatch "${FILESDIR}/${PN}-2.20.10-custom-session.patch"

	# ssh-agent handling must be done at xinitrc.d, bug #220603
	epatch "${FILESDIR}/${PN}-2.20.10-xinitrc-ssh-agent.patch"

	# Fix wrong DESKTOP_SESSION set if ${HOME}/.dmrc is not found or
	# does not contain any relevant data and autologin enabled, bug #281442
	epatch "${FILESDIR}/${PN}-2.20.10-desktop-session-dmrc-autologin.patch"

	# Fix 24 hour combo box in mdmsetup, bug #301151
	# patch imported from ubuntu mirrors
	epatch "${FILESDIR}/${PN}-2.20.10-gdmsetup-24hr-combo.patch"

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"
		
	# Rename gdm to mdm in old GDM Gentoo specific tarball
	local gentoodir="${WORKDIR}/${GDM_EXTRA}"
	cd "${gentoodir}"
	sed -i -e 's/gdm/mdm/g' -e 's/GDM/MDM/g' -e 's/Gdm/Mdm/g' Xsession || die "sed failed"
	mv gdmplay mdmplay || die "move failed"
	cd "${gentoodir}/pam.d"
	for f in * ; do
		mv "${f}" "${f/gdm/mdm}" || die "move failed"
	done
	cd "${gentoodir}/security/console.apps"
	for f in * ; do
		sed -i -e 's/gdm/mdm/g' -e 's/GDM/MDM/g' -e 's/Gdm/Mdm/g' "${f}" || die "sed failed"
		mv "${f}" "${f/gdm/mdm}" || die "move failed"
	done
	cd "${WORKDIR}"
	if use branding ; then
		for d in gentoo-* ; do
			sed -i -e 's/Gdm/Mdm/g' "${d}/GdmGreeterTheme.desktop" || die "sed failed"
			mv "${d}/GdmGreeterTheme.desktop" "${d}/MdmGreeterTheme.desktop" || die "move failed"
		done
	fi
}

src_install() {
	gnome2_src_install

	local gentoodir="${WORKDIR}/${GDM_EXTRA}"

	# mdm-binary should be mdm to work with our init (#5598)
	rm -f "${D}/usr/sbin/mdm"
	dosym /usr/sbin/mdm-binary /usr/sbin/mdm

	# our x11's scripts point to /usr/bin/mdm
	dosym /usr/sbin/mdm-binary /usr/bin/mdm

	# log, etc.
	keepdir /var/log/mdm
	keepdir /var/mdm

	fowners root:mdm /var/mdm
	fperms 1770 /var/mdm

	# add a custom xsession .desktop by default (#44537)
	exeinto /etc/X11/dm/Sessions
	doexe "${gentoodir}/custom.desktop"

	# add xinitrc.d scripts
	exeinto /etc/X11/xinit/xinitrc.d
	doexe "${FILESDIR}/49-keychain"
	doexe "${FILESDIR}/50-ssh-agent"

	# install XDG_DATA_DIRS mdm changes
	echo 'XDG_DATA_DIRS="/usr/share/mdm"' > 99xdg-mdm
	doenvd 99xdg-mdm

	# add a custom sound playing script (#248253)
	dobin "${gentoodir}/mdmplay"

	# avoid file collision, bug #213118
	rm -f "${D}/usr/share/xsessions/gnome.desktop"

	# We replace the pam stuff by our own
	rm -rf "${D}/etc/pam.d"

	if use pam ; then
		use gnome-keyring && sed -i "s:#Keyring=::g" "${gentoodir}"/pam.d/*

		dopamd "${gentoodir}"/pam.d/*
		dopamsecurity console.apps "${gentoodir}/security/console.apps/mdmsetup"
	fi

	# use graphical greeter local
	sed -i -e "s:#Greeter=/usr/libexec/mdmlogin:Greeter=/usr/libexec/mdmgreeter:" \
		"${D}"/usr/share/mdm/defaults.conf || die

	# list available users
	sed -i -e "s:^#MinimalUID=.*:MinimalUID=1000:" "${D}"/usr/share/mdm/defaults.conf || die
	sed -i -e "s:^#IncludeAll=.*:IncludeAll=true:" "${D}"/usr/share/mdm/defaults.conf || die

	# Fix old X11R6 paths
	sed -i -e "s:/usr/X11R6/bin:/usr/bin:" "${D}"/usr/share/mdm/defaults.conf || die

	# Use Clearlooks as default theme, bug #268496
	sed -i -e "s:#GtkTheme=Default:GtkTheme=Clearlooks:" "${D}"/usr/share/mdm/defaults.conf || die

	# Wait more before assuming Xserver is defunct, bug #378765
	sed -i -e "s:MdmXserverTimeout=10:MdmXserverTimeout=25:" "${D}"/usr/share/mdm/defaults.conf || die

	# Move Gentoo theme in
	if use branding ; then
		mv "${WORKDIR}"/gentoo-*  "${D}/usr/share/mdm/themes"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "To make MDM start at boot, edit /etc/conf.d/xdm"
	elog "and then execute 'rc-update add xdm default'."

	elog "MDM has changed the location of its configuration file.  Please"
	elog "edit /etc/X11/mdm/custom.conf.  The factory defaults are located"
	elog "at /usr/share/mdm/{defaults.conf,factory-defaults.conf}"

	elog "See README.install for more information about the change."

	if use gnome-keyring; then
		elog "For autologin to unlock your keyring, you need to set an empty"
		elog "password on your keyring. Use app-crypt/seahorse for that."
	fi

	if [ -f "/etc/X11/mdm/mdm.conf" ]; then
		elog "You had /etc/X11/mdm/mdm.conf which is the old configuration"
		elog "file.  It has been moved to /etc/X11/mdm/mdm-pre-gnome-2.16"
		mv /etc/X11/mdm/mdm.conf /etc/X11/mdm/mdm-pre-gnome-2.16
	fi

	# Soft restart, assumes Gentoo defaults for file locations
	# Do restart after mdm.conf move above
	FIFOFILE=/var/mdm/.mdmfifo
	PIDFILE=/var/run/mdm.pid

	if [ -w ${FIFOFILE} ] ; then
		if [ -f ${PIDFILE} ] ; then
			if kill -0 `cat ${PIDFILE}`; then
				(echo;echo SOFT_RESTART) >> ${FIFOFILE}
			fi
		fi
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm

	if [ "$(rc-config list default | grep xdm)" != "" ] ; then
		elog "To remove MDM from startup please execute"
		elog "'rc-update del xdm default'"
	fi
}