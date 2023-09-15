doas qemu-system-x86_64 \
    -m 4096M \
    -enable-kvm \
    -kernel "$HOME/Downloads/vmlinuz-linux" \
    -initrd /tmp/initramfs.linux_amd64.cpio \
    -nographic -append "console=ttyS0" \
    -device e1000,netdev=host0\
    -netdev user,id=host0,net=192.168.0.0/24,dhcpstart=192.168.0.10,ipv6=off


    -net nic,vlan=0,model=virtio \
    -net user,vlan=0,hostfwd=tcp::2222-:2222,hostname=u-boot \

    -net nic,macaddr=52:54:aa:aa:aa:aa

    -nic user,model=virtio-net-pci
    #-nic user,model=virtio
    #-object rng-random,filename=/dev/urandom,id=rng0 \
    #-device virtio-rng-pci,rng=rng0 \
    #-serial mon:stdio \
    #-enable-kvm \
     #-netdev user,id=mynet0,net=192.168.76.0/24,dhcpstart=192.168.76.9

# tiny core linux
qemu-system-x86_64 -enable-kvm \
    -m 2048 \
    -nic user,model=virtio \
    -cdrom Core-current.iso\
    -drive file=tinycore.qcow2,media=disk,if=virtio

# rminnich's
doas qemu-system-x86_64 \
    -kernel "$HOME/Downloads/vmlinuz-linux" \
    -cpu  max \
     -s   \
     -m 1024m \
     -machine q35  \
     -initrd /tmp/initramfs.linux_amd64.cpio \
     -object rng-random,filename=/dev/urandom,id=rng0 \
     -device virtio-rng-pci,rng=rng0 \
     -serial mon:stdio \
     -append earlyprintk=ttyS0,115200\ console=ttyS0 \
     -device vhost-vsock-pci,guest-cid=42 \
     -monitor /dev/null  \
     -device virtio-net-pci,netdev=n1 \
     -netdev user,id=n1,hostfwd=tcp:127.0.0.1:17010-:17010,net=192.168.1.0/24,host=192.168.1.1 \
     -debugcon file:debug.log -global isa-debugcon.iobase=0x402 \
     -nographic
