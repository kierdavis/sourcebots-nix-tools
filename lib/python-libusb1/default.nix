{ fetchurl, python27Packages }:

python27Packages.buildPythonPackage rec {
  name = "libusb1-1.6.4";
  src = fetchurl {
    url = "mirror://pypi/l/libusb1/${name}.tar.gz";
    sha256 = "03b7xrz8vqg8w0za5r503jhcmbd1ls5610jcja1rqz833nf0v4wc";
  };
}
