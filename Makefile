all: build-raw

build-raw:
	nixos-generate --format raw-efi --configuration ./configuration.nix -o result

build-iso:
	nixos-generate --format iso --configuration ./configuration.nix -o result
