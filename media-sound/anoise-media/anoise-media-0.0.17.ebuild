EAPI=7

inherit unpacker

DESCRIPTION="Ambient Noise Player (media files). Coffee shop, Fire, Forest Night, Rain, Sea, Storm, Wind."
HOMEPAGE="https://launchpad.net/anoise"
SRC_URI="https://launchpad.net/~costales/+archive/ubuntu/anoise/+files/${PN}_${PV}_all.deb"

LICENSE="CC-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

scr_unpack() {
	unpack_deb "${A}" || die
}

src_install() {
	doins -r "${WORKDIR}"/usr || die
}

