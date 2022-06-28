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
source="https://github.com/scipy/scipy/archive/$com.zip
	missing-int64_t.patch
	"
builddir="$srcdir"/scipy-$com

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

build() {
	python3 setup.py config_fc --fcompiler=gnu95 build
}

package() {
	python3 setup.py install --prefix=/usr --root="$pkgdir"
}
