#!/bin/bash

echo "Installing FFmpeg."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# Setup libfaac dependency
sed -i '/^# deb.*multiverse/ s/^# //' /etc/apt/sources.list && apt-get update && apt-get install libfaac-dev -y --force-yes

# Install dependencies
apt-get install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev yasm libx264-dev libmp3lame-dev unzip x264 libgsm1-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjpeg-dev libschroedinger-dev libspeex-dev libvpx-dev libxvidcore-dev libdc1394-22-dev -y --force-yes

# Download FFmpeg
if [ ! -f "$DOWNLOAD_DIR/ffmpeg-$FFMPEG_VERSION.tar.gz" ]; then
  echo "Downloading FFMpeg"
  wget -q -O "$DOWNLOAD_DIR/ffmpeg-$FFMPEG_VERSION.tar.gz" "http://www.ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.gz"
fi
cd /tmp
cp "$DOWNLOAD_DIR/ffmpeg-$FFMPEG_VERSION.tar.gz" /tmp
tar -xzvf ffmpeg-"$FFMPEG_VERSION".tar.gz

# Compile FFmpeg
cd ffmpeg-"$FFMPEG_VERSION" && ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libdc1394 --enable-libfaac --enable-libgsm --enable-libmp3lame --enable-libopenjpeg --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libxvid && make && make install && ldconfig
