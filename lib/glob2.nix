{ fetchurl, python27Packages }:

python27Packages.buildPythonPackage rec {
  name = "glob2-${version}";
  version = "0.5";

  src = fetchurl {
    url = "mirror://pypi/g/glob2/${name}.tar.gz";
    sha256 = "17zycsxld4hhbsa0ffxdm5kcnfhanijrchff1ndz7sjdmj3lp54g";
  };

  doCheck = false;
}
