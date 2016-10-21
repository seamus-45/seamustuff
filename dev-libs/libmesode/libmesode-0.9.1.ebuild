# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit autotools git-r3

DESCRIPTION="Fork of libstrophe for use with Profanity XMPP Client."
HOMEPAGE="https://github.com/boothj5/libmesode"
EGIT_REPO_URI="git://github.com/boothj5/libmesode.git"

KEYWORDS="~amd64 ~x86"
if [[ $PV != 9999 ]]; then
	EGIT_COMMIT=$PV
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT GPL-3"
SLOT="0"
IUSE="doc"

RDEPEND="dev-libs/expat
	dev-libs/openssl"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	eautoreconf
}

src_compile() {
	emake

	if use doc ; then
		doxygen || die
	fi
}

src_install() {
	einstall
	dodoc "LICENSE.txt" "README.markdown" || die
	use doc && dohtml -r docs/html/*
}
