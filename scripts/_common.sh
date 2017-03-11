#
# Common variables
#
APPNAME="freshrss"
# FreshRSS version
VERSION="1.6.2"

# FreshRSS complete tarball checksum
FRESHRSS_SOURCE_SHA256="06bcdfbde53bd8f01b8376ee28a4f1f9630c3409d5dc12f02f74f2f7aff4a6f9"

# Remote URL to fetch FreshRSS source tarball
FRESHRSS_SOURCE_URL="https://github.com/FreshRSS/FreshRSS/archive/1.6.3.tar.gz"

PKGDIR=$(cd ../; pwd)

#apt dependencies
DEPS_PKG_NAME="freshrss-deps"

#
# Common helpers
#
# Download and extract FreshRSS sources to the given directory
# usage: extract_freshrss DESTDIR
extract_freshrss() {
  local DESTDIR=$1

  # retrieve and extract FreshRSS tarball
  rc_tarball="${DESTDIR}/freshrss.tar.gz"
  wget -q -O "$rc_tarball" "$FRESHRSS_SOURCE_URL" \
    || ynh_die "Unable to download FreshRSS tarball"
  echo "$FRESHRSS_SOURCE_SHA256 $rc_tarball" | sha256sum -c >/dev/null \
    || ynh_die "Invalid checksum of downloaded tarball"
  tar xf "$rc_tarball" -C "$DESTDIR" --strip-components 1 \
    || ynh_die "Unable to extract FreshRss tarball"
  sudo rm "$rc_tarball"
}

install_freshrss_dependencies() {
    ynh_package_install_from_equivs ../conf/${DEPS_PKG_NAME}.control \
      || ynh_die "Unable to install dependencies"
}
