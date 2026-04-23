{
  config,
  pkgs,
  inputs,
  ...
}:

let
  inherit (inputs) hermes-agent;
in
{
  imports = [
    hermes-agent.nixosModules.default
  ];

  services.hermes-agent = {
    enable = true;
    settings = {
      model = {
        base_url = "http://localhost:8080/v1";
        default = "Qwen3-8B-GGUF";
      };
      auxiliary = {
        vision = {
          base_url = "http://localhost:8080/v1";
          model = "Qwen3-8B-GGUF";
        };
        web_extract = {
          base_url = "http://localhost:8080/v1";
          model = "Qwen3-8B-GGUF";
        };
      };
      compression = {
        enabled = true;
        threshold = 0.50;
        summary_base_url = "http://localhost:8080/v1";
        summary_model = "Qwen3-8B-GGUF";
      };
      terminal = {
        backend = "local";
        cwd = ".";
        timeout = 180;
      };
      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };
      approval_mode = "ask";
      display = {
        tool_progress = "all";
        streaming = false;
      };
    };
    addToSystemPackages = true;
  };
}
