{ ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1-extreme/gen2>
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.optimus_prime = {
    enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  services.xserver.wacom.enable = true;
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

}
