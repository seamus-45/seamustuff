# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils subversion

DESCRIPTION="Cross Platform file manager."
HOMEPAGE="http://doublecmd.sourceforge.net/"
ESVN_REPO_URI="svn://svn.code.sf.net/p/doublecmd/code/trunk"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS=""

IUSE="qt4 -gtk2"

REQUIRED_USE=" ^^ ( qt4 gtk2 )"

RDEPEND=">=dev-lang/lazarus-1
         sys-apps/dbus
         dev-libs/glib
         sys-libs/ncurses
         x11-libs/libX11
"

DEPEND="${RDEPEND}
	gtk2? ( x11-libs/gtk+:2 )
        qt4? ( >=dev-qt/qtpascal-2.5 )
"

src_prepare(){
    use qt4 && export lcl="qt" || export lcl="gtk2"
    use amd64 && export CPU_TARGET="x86_64" || export CPU_TARGET="i386"

    export lazpath="/usr/share/lazarus"

    if use qt4 ; then
	cp /usr/lib/qt4/libQt4Pas.so plugins/wlx/WlxMplayer/src/
	cp /usr/lib/qt4/libQt4Pas.so src/
    fi

    find ./ -type f -name "build.sh" -exec sed -i 's#$lazbuild #$lazbuild --lazarusdir=/usr/share/lazarus #g' {} \;
}

src_compile(){
	./build.sh beta
}

src_install(){
	diropts -m0755
	dodir /usr/share

	install/linux/install.sh --portable-prefix=build

	doicon -s 48 "${S}/build/doublecmd/doublecmd.png"
	rm "${S}/build/doublecmd/doublecmd.png"

	rsync -a "${S}/build/" "${D}/usr/share/" || die "Unable to copy files"

	dosym ../share/doublecmd/doublecmd /usr/bin/doublecmd

	make_desktop_entry doublecmd "Double Commander" "doublecmd" "Utility;" || die "Failed making desktop entry!"
}
