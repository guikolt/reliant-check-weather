script to check weather forecast for JPA and backup this data, using puppet5 and shellscript

$ tested on
- Debian GNU/Linux 10 (buster)
- Puppet v5.5.10

$ modules/weather/files/weather_forecast
- grabs weather forecast information from wttr.in
- writes into /tmp/weather_forecast/YYYY-MM-DD
- application level log in ${folder}/${city}.forecast.log
- runs either as a local shellscript or as a service

$ modules/weather/files/weather_backup
- backups folders/files from /tmp/weather_forecast
- saves backup to /backup/m-d-H-M/weather.backup.tar.gz
- retains 10 days of backups
- runs cleanup only if current backup succeeded

$ manifests/weather.pp
- manages both shellscripts
- creates service to manage weather_forecast script
- adds cronjob to run backups every day, hour 00 minute 00
