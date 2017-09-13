default['linux_hardening']['cron_dirs'] = %w(cron.hourly cron.daily cron.weekly cron.monthly cron.d)
default['linux_hardening']['cron_files'] = %w(crontab)



default['linux_hardening']['etc_files1'] = %w(passwd passwd- group group-)
default['linux_hardening']['etc_files2'] = %w(shadow shadow- gshadow gshadow-)

#default['linux_hardening']['xinetd_services'] = %w(chargen daytime discard echo time rsh talk telnet tftp rsync)
default['linux_hardening']['xinetd_services'] = %w(chargen-dgram  chargen-stream  daytime-dgram  daytime-stream  discard-dgram  discard-stream  echo-dgram  echo-stream  rsync  tcpmux-server  time-dgram  time-stream)