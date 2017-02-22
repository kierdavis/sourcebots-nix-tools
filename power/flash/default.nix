{ stdenv, powerFirmware, openocd, stm32flash, writeScriptBin }:

let
  flash = name: image: writeScriptBin name ''
    #!${stdenv.shell}
    ${openocd}/bin/openocd -f ${powerFirmware}/oocd/pbv4.cfg \
      -c "init" \
      -c "reset init" \
      -c "stm32f1x mass_erase 0" \
      -c "flash write_image ${image}" \
      -c "reset" \
      -c "shutdown"
  '';
in
  {
    fw = flash "pbv4-flash-fw" "${powerFirmware}/images/pbv4.elf";
    testfw = flash "pbv4-flash-testfw" "${powerFirmware}/images/pbv4_test.elf";

    testuart = writeScriptBin "pbv4-flash-testuart" ''
      #!${stdenv.shell}
      if [ -z "$1" ]; then
        echo "usage: $0 /dev/ttyUSB0"
        exit 2
      fi
      ${stm32flash}/bin/stm32flash -b 115200 -w ${powerFirmware}/images/pbv4_test.bin "$1"
    '';
  }
