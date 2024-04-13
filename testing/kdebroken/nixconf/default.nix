{ ... }: { 


imports = [ 
		 ./hardware-configuration.nix
    	 ./zram.nix
    	 ./boot.nix
     	 ./configuration.nix
     	 ./security.nix
     	 ./intel.nix
     	 ./wayland.nix
     	 ./kde.nix
		 ./pkgs.nix
         ./network.nix
         ./systemd.nix
        #./secureboot.nix
            ];
}
