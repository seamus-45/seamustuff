# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="DNS toolkit for Python 3"
HOMEPAGE="http://www.dnspython.org/ http://pypi.python.org/pypi/dnspython3"
SRC_URI="http://www.dnspython.org/kits3/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pycrypto"
RDEPEND="${DEPEND}"

#DOCS="ChangeLog README"
#PYTHON_MODNAME="dns"

