{ config
, pkgs
, inputs
, ...
}:

{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        name = "Default";
        id = 0;

        # Enhanced privacy settings
        settings = {
          # Privacy & Security
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.pbmode.enabled" = true;
          "privacy.resistFingerprinting" = false;
          "network.cookie.cookieBehavior" = 1; # Accept cookies from visited sites only
          "privacy.sanitize.sanitizeOnShutdown" = false;

          # Disable telemetry
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.telemetry.enabled" = false;
          "toolkit.telemetry.enabled" = false;

          # Disable Pocket
          "extensions.pocket.enabled" = false;

          # Disable sponsored shortcuts
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # Performance
          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;

          # Dark theme
          "ui.systemUsesDarkTheme" = 1;
          "browser.in-content.dark-mode" = true;
          "devtools.theme" = "dark";

          # Use Firefox Home (default)
          "browser.startup.homepage" = "about:home";
        };

        # Install extensions from the firefox-addons input
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          privacy-badger
        ];
      };
    };
  };
}
