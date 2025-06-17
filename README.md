# MiSTer-syncthing

![Syncthing logo](./.github/syncthing_logo.png){ width="128" height="128" style="display: block; margin: 0 auto" }

A script for running [Syncthing](https://syncthing.net/) on your MiSTer.

## Prerequisites

* An Internet connected MiSTer

## Setup

1. Add the following to `/media/fat/downloader.ini`.

```ini
[davewongillies/syncthing]
db_url = https://raw.githubusercontent.com/davewongillies/MiSTer-syncthing/db/db.json.zip
```

2. Run `update` or `update_all` from the Scripts menu.
3. From the Scripts menu run `syncthing`.
4. Open [http://mister.local:8384](http://mister.local:8384)
