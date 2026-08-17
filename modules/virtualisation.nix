{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    # 25.11 still defaults to docker_28, which is unmaintained.
    package = pkgs.docker_29;
  };
}
