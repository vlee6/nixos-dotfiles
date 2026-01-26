{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;

    policies = {
      Bookmarks = [
        {
          Title = "Gmail";
          URL = "https://mail.google.com/mail/u/0/#inbox";
          Placement = "toolbar";
        }
        {
          Title = "Docs";
          URL = "https://docs.google.com/document/u/0/?tgif=d";
          Placement = "toolbar";
        }
        {
          Title = "Canvas";
          URL = "https://canvas.harvard.edu";
          Placement = "toolbar";
        }
        {
          Title = "my.harvard";
          URL = "https://portal.my.harvard.edu/psp/hrvihprd/EMPLOYEE/EMPL/h/?tab=HU_SSS";
          Placement = "toolbar";
        }
        {
          Title = "Peoplesoft";
          URL = "https://peoplesoft.hrapps.harvard.edu";
          Placement = "toolbar";
        }

        {
          Title = "Classes";
          Placement = "toolbar";
        }
        {
          Title = "CS1200";
          URL = "https://edstem.org/us/courses/89686/discussion";
          Folder = "Classes";
        }
      ];
    };

    profiles = {
      vlee = {
        id = 0;
        name = "vlee";
        isDefault = true;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          ctrl-number-to-switch-tabs
        ];
      };
    };
  };

  stylix.targets.firefox.profileNames = ["vlee"];
}
