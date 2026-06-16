{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.LLAMA_CPP_API_KEY = "sk-no-key-required";

  environment.systemPackages = with pkgs; [
    wget
    opencode
    agent-browser
    chromium
    llama-cpp-cuda
    ik-llama-cpp-cuda
    ripgrep
    claude-code
    mindustry-wayland
    antigravity
    discord
    (sddm-astronaut.override {
      embeddedTheme = "astronaut";
    })
    (pkgs.writeShellScriptBin "hashcat" ''
      export LD_LIBRARY_PATH=/run/opengl-driver/lib:${pkgs.cudaPackages.cudatoolkit}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
      exec ${pkgs.hashcat}/bin/hashcat "$@"
    '')
  ];
}
