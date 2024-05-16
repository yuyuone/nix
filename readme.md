[nixos-generators](https://github.com/nix-community/nixos-generators/tree/master)

```
nix-shell
make build-raw 
```

```
nix-shell
make build-iso 
```

```
qemu-system-x86_64 -enable-kvm -cdrom result/iso/nixos.iso -device ac97 -display gtk -smp 2 -net nic -net user -m 2048 
```

```
sudo dd if=result/nixos.img of=/dev/sdb bs=32M conv=sync status=progress
```
