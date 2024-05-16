{ pkgs, modulesPath, lib, ... }: {
  imports = [
    ./configuration.nix
  ];

  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  isoImage.squashfsCompression = null;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
}
