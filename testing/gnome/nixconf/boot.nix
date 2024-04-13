{ config, lib, pkgs, ...}:

# Thanks to https://wiki.archlinux.org/title/Sysctl#TCP/IP_stack_hardening + https://libreddit.privacydev.net/r/NixOS/comments/1aqfuxq/bootloaderkernel_hardening_for_nixos/ and tails hardening doc + https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings

{

################################################################################
# BTRFS
################################################################################

  boot.kernelParams = [ 
    "slab_nomerge" 
    "init_on_alloc=1" 
    "init_on_free=1" # this option erase the memory at shudown for our setup it's useful !
    "page_alloc.shuffle=1" 
    "pti=on"
    "vsyscall=none"
    "vdso32=0"
    "debugfs=off" 
    "oops=panic" 
    "slub_debug=FZ"
    "module.sig_enforce=1" 
    "lockdown=off" 
    "mce=0" 
    "quiet"
    "random.trust_cpu=off"
    "loglevel=0" 
    "mds=full,nosmt"
    "ipv6.disable=1"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
     "security=apparmor"
    ];
    
 
  #boot.tmp.useTmpfs = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.supportedFilesystems = [ "btrfs" ];
  boot.initrd.supportedFilesystems = [ "vfat" "btrfs" ];
  boot.blacklistedKernelModules = [
  "dccp" "sctp" "rds" "tipc" "n-hdlc" "ax25" "netrom" "x25" "rose" "decnet"
  "econet" "af_802154" "ipx" "appletalk" "psnap" "p8023" "p8022" "can"
  "atm" "cramfs" "freevxfs" "jffs2" "hfs" "hfsplus" "udf" "vivid" "thunderbolt" "firewire-core"
];

########### HARDENING #############
# make sudo required for accessing process lists

users.groups.proc = {};
systemd.services.systemd-logind.serviceConfig = {
  SupplementaryGroups = [ "proc" ];
};

 # hardening proc
fileSystems."/proc" = {
  fsType = "proc";
  device = "proc";
  options = [ "nosuid" "nodev" "noexec" "hidepid=2" ];
  neededForBoot = true;
};

# hardening filesystems root etc...
fileSystems."/".options = [ "defaults" "noexec" ];
fileSystems."/boot".options = [ "defaults" "nosuid" "nodev" "noexec" ];



 boot.kernel.sysctl = {
    # Network
    "net.core.netdev_max_backlog" = "16384";
    "net.core.somaxconn" = "8192";
    "net.core.rmem_default" = "1048576";
    "net.core.wmem_default" = "1048576";
    "net.core.optmem_max" = "65536";
    "net.core.bpf_jit_harden" = "2"; # added
    "dev.tty.ldisc_autoload" = "0"; #added
    "net.ipv4.tcp_rfc1337" = "1"; #added
    "net.ipv4.udp_rmem_min" = "8192";
    "net.ipv4.udp_wmem_min" = "8192";
    "net.ipv4.tcp_fastopen" = "3";
    "net.ipv4.tcp_max_syn_backlog" = "8192";
    "net.ipv4.tcp_max_tw_buckets" = "2000000";
    "net.ipv4.tcp_tw_reuse" = "1";
    "net.ipv4.tcp_fin_timeout" = "10";
    "net.ipv4.tcp_slow_start_after_idle" = "0";
    "net.ipv4.tcp_keepalive_time" = "60";
    "net.ipv4.tcp_keepalive_intvl" = "10";
    "net.ipv4.tcp_keepalive_probes" = "6";
    "net.ipv4.tcp_mtu_probing" = "1";
    "net.ipv4.tcp_sack" = "1";
    "net.ipv4.tcp_syncookies" = "1";
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = "1";
    "net.ipv4.conf.all.log_martians" = "1";
    "net.ipv4.conf.all.accept_redirects" = "0";
    "net.ipv4.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.all.secure_redirects" = "0";
    "net.ipv4.conf.default.secure_redirects" = "0";
    "net.ipv6.conf.all.accept_redirects" = "0";
    "net.ipv6.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.all.send_redirects" = "0";
    "net.ipv4.conf.default.send_redirects" = "0";
    "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";


    
    # Kernel
    "kernel.randomize_va_space" = "2";
    "kernel.sysrq" = "0";
    "kernel.core_uses_pid" = "1";
    "kernel.kptr_restrict" = "2";
    "kernel.yama.ptrace_scope" = "3";
    "kernel.dmesg_restrict" = "1";
    "kernel.printk" = "3 3 3 3";
    "kernel.unprivileged_bpf_disabled" = "1";
    "kernel.kexec_load_disabled" = "1";
    "kernel.unprivileged_userns_clone" = "1";
    "kernel.pid_max" = "32768";
    "kernel.panic" = "10";
    "kernel.panic_on_oops" = "1";
    "kernel.perf_event_paranoid" = "3";
    "kernel.perf_cpu_time_max_percent" = "1";
    "kernel.perf_event_max_sample_rate" = "1";
    "randomize_kstack_offset" = "on";
    "kernel.ftrace_enabled" = lib.mkDefault false;
  
    # File System
    "fs.suid_dumpable" = "0";
    "fs.protected_hardlinks" = "1";
    "fs.protected_symlinks" = "1";
    "fs.protected_fifos" = "2";
    "fs.protected_regular" = "2";
    "fs.file-max" = "9223372036854775807";
    "fs.inotify.max_user_watches" = "524288";

    # Virtualization
  "vm.drop_caches" = "3";
  "vm.overcommit_memory" = "2";
  "vm.panic_on_oom" = "0";
  "vm.mmap_min_addr" = "65536";
  "vm.mmap_rnd_bits" = "32";
  "vm.mmap_rnd_compat_bits" = "16";
  "vm.unprivileged_userfaultfd" = "0";
  "vm.oom_kill_allocating_task" = "1";
  "vm.vfs_cache_pressure" = "100";
  "vm.dirty_background_ratio" = "5";
  "vm.dirty_ratio" = "10";
  "vm.dirty_expire_centisecs" = "3000";
  "vm.dirty_writeback_centisecs" = "3000";
  "vm.min_free_kbytes" = "65536";


      ########## HARDENING ############
    
  };
}
