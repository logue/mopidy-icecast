#!/bin/bash

echo "💡 initializing..."
rm -rf /tmp/*
rm -rf /var/log/icecast2/*

echo "🔈 Starting pulseaudio..."
su - user -c "pulseaudio -D --exit-idle-time=-1"
sleep 2

echo "📻 Starting Icecast2..."
/etc/init.d/icecast2 start
sleep 2

echo "🎵 Starting mopidy..."
su - user -c "/usr/bin/mopidy --version"
su - user -c "/usr/bin/mopidy --config /data/mopidy.conf"
sleep 2

echo "🛂 Starting custom Boot Script..."
su - user -c "bash /data/custom_boot.sh"
sleep 2

echo "🧊 Starting darkice..."
su - user -c "darkice -c /data/darkice.cfg"
sleep 2

echo "🚩 Ready."
