{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;

    profiles.vlee = {
      bookmarks = [
        {
	  name = "Gmail";
	  url = "https://mail.google.com/mail/u/0/#inbox";
	}
	{
          name = "Docs";
          url = "https://docs.google.com/document/u/0/?tgif=d";
	}
	{
          name = "Canvas";
	  url = "https://canvas.harvard.edu";
	}
	{
	  name = "my.harvard";
	  url = "https://portal.my.harvard.edu/psp/hrvihprd/EMPLOYEE/EMPL/h/?tab=HU_SSS";
	}
	{
          name = "Peoplesoft";
	  url = "https://peoplesoft.hrapps.harvard.edu";
	}
      ];

      extensions = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        ctrl-number-to-switch-tabs
      ];
    };

  };
}
