{ stdenv, powerFirmware, openocd, writeScriptBin }:

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
  }
