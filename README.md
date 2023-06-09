# Mopidiy-icecast

UNDER CONSTRUCTION.

Run mopidy plus various extensions in a docker container and stream as icecast.

## Entry point

| Volume | Description                       |
| ------ | --------------------------------- |
| /media | Your media file directory         |
| /data  | Mopidy config and cache directory |

| Port  | Description               |
| ----- | ------------------------- |
| 1780  | Iris snapcast             |
| 6600  | MPD                       |
| 6680  | Mopidy Web Interface Port |
| 8337  | Beats                     |
| 20300 | Icecast                   |

## Plugins

- Mopidy-ALSAMixer
- Mopidy-Beets
- Mopidy-File
- Mopidy-HTTP
- Mopidy-InternetArchive
- Mopidy-Iris
- Mopidy-Local
- Mopidy-M3U
- Mopidy-MPD
- Mopidy-MPRIS
- Mopidy-Podcast
- Mopidy-Podcast-iTunes
- Mopidy-Scrobbler
- Mopidy-SoftwareMixer
- Mopidy-SomaFM
- Mopidy-SoundCloud
- Mopidy-Spotify
- Mopidy-Stream
- Mopidy-TuneIn
- Mopidy-WebSettings
- Mopidy-YTMusic
- Mopidy-YouTube
- Mopidy-dLeyna

## RUN

```ssh
docker run -d --name mopidiy-icecast --net host \
  -p 1780:1780 \
  -p 6600:6600 \
  -p 6680:6680 \
  -p 8337:8337 \
  -p 20300:20300 \
  -v /data:/mopidy-data \
  -v /media:/media rawdlite/mopidy
```

## License

©2023 by Logue. Licensed under the [MIT License](LICENSE).

This project uses the following libraries:

- [Mopidy](https://mopidy.com/)
- [LAME](https://lame.sourceforge.io/)
- [icecast2](https://icecast.org/)
- [darkice](http://www.darkice.org/)
- [blank-audio](https://github.com/anars/blank-audio)

SPOTIFY is a trademark of Spotify AB.
