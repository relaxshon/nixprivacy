{ ... }: { 


imports = [ 
  	./hardware-configuration.nix
    	./zram.nix
    	#./systemd.nix
    	#./systemd2.nix
    	./boot.nix
     	./configuration.nix
	./pkgs.nix
	./autolog.nix
	./intel.nix
        ./network.nix
            ];
}
