{ pkgs, ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs =
      let
        notPrefix = ''export XDG_RUNTIME_DIR=/run/user/$(id -u) && export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus" && ${pkgs.libnotify}/bin/notify-send "Go to bed Job"'';
      in
      [
        ''0 23 * * 0-4 josh ${notPrefix} "Shutting system down in one hour"''
        ''50 23 * * 0-4 josh ${notPrefix} "Shutting system down in 10 min"''
        "59 23 * * 0-4 root shutdown -h now"
        ''0 1 * * 6-7 josh ${notPrefix} hello "Shutting system down in one hour"''
        ''50 1 * * 6-7 josh ${notPrefix} hello "Shutting system down in one 10 min"''
        "59 1 * * 6-7 root shutdown -h now"
      ];
  };
}
