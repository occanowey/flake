{
  buildEnv,
  pkgs,
}:
buildEnv {
  name = "net-debug";

  paths = [
    pkgs.dig
    pkgs.traceroute
    pkgs.tcpdump
  ];
}
