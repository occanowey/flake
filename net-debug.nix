{
  buildEnv,
  pkgs,
}:
buildEnv {
  name = "net-debug";

  paths = [
    pkgs.dig
    pkgs.tcpdump

    (
      if pkgs.stdenv.isLinux
      then pkgs.traceroute
      else pkgs.inetutils
    )
  ];
}
