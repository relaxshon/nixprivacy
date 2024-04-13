{ ... }: { 


imports = [ 
  	 ./hardware-configuration.nix
    	 ./zram.nix
    	 ./systemd.nix
    	 ./boot.nix
    	 ./gnome.nix
     	 ./configuration.nix
     	 ./intel.nix
	./pkgs.nix
        ./network.nix
        #./secureboot.nix
            ];
}
