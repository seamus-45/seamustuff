EAPI=7
PYTHON_COMPAT=( python2_7 python3_6 )

inherit distutils-r1 gnome2-utils git-r3

DESCRIPTION="Ambient Noise Player. Integrate noise into your sound indicator and relax or concentrate."
HOMEPAGE="https://launchpad.net/anoise"
EGIT_REPO_URI="https://github.com/costales/anoise"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-sound/anoise-media
dev-python/gst-python:1.0
media-libs/gstreamer:1.0[introspection]
x11-libs/gtk+:3[introspection]
net-libs/webkit-gtk:4[introspection]
"

DEPEND="${RDEPEND}
dev-python/setuptools[${PYTHON_USEDEP}]
dev-python/python-distutils-extra[${PYTHON_USEDEP}]
"

src_unpack() {
	git-r3_src_unpack
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
