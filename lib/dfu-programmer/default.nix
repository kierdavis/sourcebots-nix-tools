{ stdenv, autoconf264, automake112x, fetchgit, libusb, pkgconfig }:
let
  version = "0.7.2";
in
stdenv.mkDerivation rec {
  name = "dfu-programmer-${version}";

  buildInputs = [ autoconf264 automake112x libusb ];

  # src = fetchgit {
  #   url = "git://git.infradead.org/users/borneoa/dfu-programmer.git";
  #   rev = "f99ba30722db042251b08e18ca47f8f58be83cd7"; # head of 'dev' branch
  #   sha256 = "0az5a6q59fcrgk78ri6v1m1pd4rcyxvrbjlq8yz66wnw3wnhlas2";
  # };
  src = /home/kier/tmp/dfu-programmer;

  ACLOCAL_PATH = "${pkgconfig}/share/aclocal";
  preConfigure = "./bootstrap.sh";

  configureFlags = [ "--disable-libusb_1_0" ];

  meta = with stdenv.lib; {
    license = licenses.gpl2;
    description = "A Device Firmware Update based USB programmer for Atmel chips with a USB bootloader";
    homepage = http://dfu-programmer.sourceforge.net/;
    maintainers = [ maintainers.the-kenny ];
    platforms = platforms.linux;
  };
}
