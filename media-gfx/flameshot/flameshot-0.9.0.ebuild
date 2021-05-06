# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://flameshot.js.org"
EGIT_REPO_URI="https://github.com/seamus-45/flameshot.git"
EGIT_BRANCH="custom-upload-hosting"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-qt/linguist-tools
"
