{ stdenv, motorFirmware, openocd, writeScriptBin }:

let
  flash = name: image: writeScriptBin name ''
    #!${stdenv.shell}
    ${openocd}/bin/openocd -f ${motorFirmware}/oocd/mcv4.cfg \
      -c "init" \
      -c "reset init" \
      -c "stm32f1x mass_erase 0" \
      -c "flash write_image ${image}" \
      -c "reset" \
      -c "shutdown"
  '';
in
  {
    fw = flash "mcv4-flash-fw" "${motorFirmware}/images/mcv4.elf";
    testfw = flash "mcv4-flash-testfw" "${motorFirmware}/images/mcv4_test.elf";
  }
