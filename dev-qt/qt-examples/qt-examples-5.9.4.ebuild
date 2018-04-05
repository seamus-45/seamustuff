# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE=""
inherit qt5-build

DESCRIPTION="Examples for the Qt5 framework"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND=""

case ${PV} in
	5.9999)
		# git dev branch
		QT5_BUILD_TYPE="live"
		EGIT_BRANCH="dev"
		;;
	5.?.9999|5.??.9999|5.???.9999)
		# git stable branch
		QT5_BUILD_TYPE="live"
		EGIT_BRANCH=${PV%.9999}
		;;
	*_alpha*|*_beta*|*_rc*)
		# development release
		MY_P=qt-everywhere-opensource-src-${PV/_/-}
		SRC_URI="https://download.qt.io/development_releases/qt/${PV%.*}/${PV/_/-}/single/${MY_P}.tar.xz"
		S=${WORKDIR}/${MY_P}
		;;
	*)
		# official stable release
		MY_P=qt-everywhere-opensource-src-${PV/_/-}
		SRC_URI="https://download.qt.io/official_releases/qt/${PV%.*}/${PV}/single/${MY_P}.tar.xz"
		S=${WORKDIR}/${MY_P}
		;;
esac
EGIT_REPO_URI="https://github.com/qt/qt5.git"

src_prepare() {
	_fdirs=$(find "${S}" -maxdepth 2 -type d -name examples)
	for _dir in $_fdirs; do
		_mod=$(basename ${_dir%/examples})
		# The various example dirs have conflicting README files, we'll rename them
		if [ -e "$_dir/README" ]; then
			mv $_dir/README ${_dir}/README.${_mod}
		fi
		# The various example dirs have conflicting .pro files, but
		# QtCreator requires them to be in the same top-level directory.
		# Matching the Qt5 installer, only the qtbase project is kept.
		# We'll just rename them all and create as symlink to the one from qtbase in src_install().
		if [ -e "$_dir/examples.pro" ]; then
			mv $_dir/examples.pro ${_dir}/examples-${_mod}.pro
		fi
	done
	qt5-build_src_prepare
}

src_configure() {
	return
}

src_compile() {
	return
}

src_install() {
	insinto ${QT5_EXAMPLESDIR}
	_fdirs=$(find "${S}" -maxdepth 2 -type d -name examples)
	for _dir in $_fdirs; do
		_mod=$(basename ${_dir%/examples})
		doins -r ${_dir}/*
	done

	# Keeping single .pro file for QtCreator. See src_prepare()
	dosym examples-qtbase.pro ${QT5_EXAMPLESDIR}/examples.pro
}
