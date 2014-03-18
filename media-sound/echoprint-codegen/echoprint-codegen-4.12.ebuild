# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Echoprint is an open source music fingerprint and resolving framework powered by the The Echo Nest."
HOMEPAGE="http://echoprint.me/codegen"
SRC_URI="https://codeload.github.com/echonest/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
  media-libs/taglib
  media-video/ffmpeg"
DEPEND="${RDEPEND}
  sys-libs/zlib
  >=dev-libs/boost-1.35
  virtual/pkgconfig"

S="${S}/src"

src_prepare() {
	sed -ie 's@ln -fs $(DESTDIR)$(LIBDIR)/@ln -s @' Makefile
}

src_install() {
	emake PREFIX="${D}/usr" install || die "installation failed"
	dodoc ../{AUTHORS,LICENSE,README.md} || die "docs failed"
}
