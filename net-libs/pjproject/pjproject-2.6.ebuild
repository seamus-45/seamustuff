# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Open source SIP, Media, and NAT Traversal Library"
HOMEPAGE="http://www.pjsip.org/"
SRC_URI="http://www.pjsip.org/release/${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/alsa-lib
	media-libs/portaudio
"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--enable-g711-codec \
		--enable-resample \
		--disable-resample-dll \
		--disable-libsamplerate \
		--disable-ssl \
		--disable-sdl \
		--disable-oss \
		--disable-video \
		--disable-ffmpeg \
		--disable-v4l2 \
		--disable-openh264 \
		--disable-libyuv \
		--disable-speex-codec \
		--disable-speex-aec \
		--disable-l16-codec \
		--disable-gsm-codec \
		--disable-g722-codec \
		--disable-g7221-codec \
		--disable-ilbc-codec  \
		--disable-silk \
		--disable-opencore-amr
}

src_compile() {
	emake dep
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	newbin pjsip-apps/bin/pjsua* pjsua
}
