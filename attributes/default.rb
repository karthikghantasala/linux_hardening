default['linux_hardening']['cron_dirs'] = %w(cron.hourly cron.daily cron.weekly cron.monthly cron.d)
default['linux_hardening']['cron_files'] = %w(crontab)

default['linux_hardening']['etc_files1'] = %w(passwd passwd- group group-)
default['linux_hardening']['etc_files2'] = %w(shadow shadow- gshadow gshadow-)
