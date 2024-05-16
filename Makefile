all: build-raw

build-raw:
	nixos-generate --format raw-efi --configuration ./configuration.nix -o result
