# Copyright 2014 Lara Maia <lara@craft.net.br>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit multilib vcs-snapshot

DESCRIPTION="Stand-alone and portable version of Gentoo's functions.sh"
HOMEPAGE="https://github.com/marcusatbang/efunctions"
GIT_COMMIT=b35f73e902fc0a6977260a1d6e8b287ae3b1c82a
SRC_URI="${HOMEPAGE}/tarball/${GIT_COMMIT} -> ${P}.tar.gz"

# FIXME(marineam): The origional functions.sh claims 2-clause BSD but
# efunctions has no license declared. Assume it is unchanged until I
# contact the author and get that sorted out...
LICENSE="BSD-2"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="!sys-apps/openrc
    !<sys-apps/baselayout-2.0
    "

src_install() {
    local dst_dir=/usr/$(get_libdir)/${PN}

    dodir $dst_dir
    insinto $dst_dir
    doins ${S}/functions.sh
    doins -r ${S}/efunctions

    fperms -R +x $dst_dir
}

pkg_postinst() {
    local dst_dir=/usr/$(get_libdir)/${PN}

    ln -s $dst_dir/functions.sh /etc/init.d/functions.sh
}

pkg_postrm() {
    unlink /etc/init.d/functions.sh
}
