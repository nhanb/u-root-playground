run: uroot.cpio
	qemu-system-x86_64 \
		-enable-kvm \
		-m 4096M \
		-cpu max \
		-kernel /boot/vmlinuz-linux \
		-initrd uroot.cpio \
		-nographic -append "console=ttyS0" \

uroot.cpio:
	u-root \
		-files /usr/lib/modules/6.5.3-arch1-1 \
		-uinitcmd "elvish -c 'modprobe e1000; dhclient -ipv6=false'" \
		-o uroot.cpio core boot 'cmds/exp/*'

linux-x86_64-qemu:
	curl -LO https://gitlab.freedesktop.org/mupuf/boot2container/-/releases/v0.9.10/downloads/linux-x86_64-qemu

clean:
	rm uroot.cpio
