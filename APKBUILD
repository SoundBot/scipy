# Contributor: Martell Malone <martellmalone@gmail.com>
# Maintainer:
pkgname=py3-scipy
pkgver=1.8.1
pkgrel=0
pkgdesc="Python library for scientific computing"
url="https://www.scipy.org/"
arch="all !mips !mips64"  # limited by py3-numpy
license="BSD-3-Clause"
depends="py3-numpy-f2py"
makedepends="cython gfortran openblas-dev>=0.3.0 py3-numpy-dev py3-setuptools
	python3-dev py3-pybind11-dev"
com="34506555aa9d222e26db57964cd195650efcc9d7"
source="missing-int64_t.patch"
#builddir="$srcdir"/scipy
builddir=/home/appuser/bld

replaces=py-scipy # Backwards compatibility
provides=py-scipy=$pkgver-r$pkgrel # Backwards compatibility

# TODO: remove when aport is available
export SCIPY_USE_PYTHRAN=0
export LDFLAGS="$LDFLAGS -shared"
# scipy is a huge library (~60 MiB) optimized for performance, so compiling
# with -Os to sacrifice performance for a few megabytes doesn't make sense.
export CFLAGS=${CFLAGS/-Os/-O2}
export CXXFLAGS=${CXXFLAGS/-Os/-O2}
export CPPFLAGS=${CPPFLAGS/-Os/-O2}

fetch() {
	echo "****** fetching  ******"
	pwd
	if [ ! -d "$srcdir" ]; then
		if [ ! -d "$SRCDEST"/scipy ]; then
			echo "** Dir doesnt exist, creating... **"
			mkdir -p "$srcdir"
			cd "${SRCDEST:-$srcdir}"
			git clone https://github.com/scipy/scipy.git
			cd scipy
			pwd
			git checkout "$com"
			git submodule update --init
			echo "source dir:"
			echo "$srcdir"
			echo "src dest:"
			echo "$SRCDEST"
			cp /home/appuser/missing-int64_t.patch "$srcdir"
			mkdir -p "$builddir"
			cp -r "$SRCDEST" "$builddir"
		else
			echo " Src dest exists"
		fi
	else
		echo "** Dir exists, skipping...** "
	fi
	echo "** done fetching **"
}

unpack() {
	echo "**** unpack  *****"
}

build() {
	echo "**** building  *****"
	pwd
	cd "$builddir"
	pwd
	ls
	cd scipy
	pwd
	python3 setup.py config_fc --fcompiler=gnu95 build
}

package() {
	echo "**** package  *****"
	pwd
	python3 setup.py install --prefix=/usr --root="$pkgdir"
}
