# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="Universal status bar content generator"
HOMEPAGE="https://github.com/shdown/luastatus"

if [[ ${PV} == *9999* ]]; then
    inherit git-r3
    SRC_URI=""
    EGIT_REPO_URI="https://github.com/shdown/${PN}.git"
    KEYWORDS=""
else
    SRC_URI="https://github.com/shdown/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3+"
SLOT="0"
IUSE="examples luajit dwm i3 +lemonbar +stdout"

DEPEND=""
RDEPEND="${DEPEND}
    luajit? ( dev-lang/luajit:2 )
    !luajit? ( dev-lang/lua:0 )
    x11-libs/libxcb
	x11-libs/xcb-util-wm
    x11-libs/libX11
    media-libs/alsa-lib
    i3? ( >=dev-libs/yajl-2.1.0 )
"

src_configure() {
    local mycmakeargs=(
        $(use luajit && echo -DWITH_LUA_LIBRARY=luajit)
        -DBUILD_BARLIB_DWM=$(usex dwm)
        -DBUILD_BARLIB_I3=$(usex i3)
        -DBUILD_BARLIB_LEMONBAR=$(usex lemonbar)
        -DBUILD_BARLIB_STDOUT=$(usex stdout)
    )
    cmake-utils_src_configure
}

src_install() {
    default
    local i wm
    if use examples; then
        dodir /usr/share/doc/${PF}/widget-examples
        docinto widget-examples
        for i in dwm i3 lemonbar stdout; do
            if use ${i}; then
                dodoc -r contrib/widget-examples/${i}
                docompress -x /usr/share/doc/${PF}/widget-examples/${i}
            fi
        done
    fi
}
