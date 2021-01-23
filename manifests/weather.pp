file { '/usr/local/bin/weather_forecast':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '700',
    source => 'puppet:///modules/weather/weather_forecast',
}

file { '/etc/systemd/system/weather.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['daemon_reload'],
    source => 'puppet:///modules/weather/weather.service',
}

exec { 'daemon_reload':
    command   => '/usr/bin/systemctl daemon-reload',
}

service { 'weather':
    ensure => running,
    enable => true,
    start  => '/usr/bin/systemctl start weather' ,
    stop   => '/usr/bin/systemctl stop weather',
    status => '/usr/bin/systemctl status weather',
}

file { '/usr/local/bin/weather_backup':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '700',
    source => 'puppet:///modules/weather/weather_backup',
}

cron { 'weather_backup':
    command => '/usr/local/bin/weather_backup',
    user    => 'root',
    hour    => 0,
    minute  => 0,
}
