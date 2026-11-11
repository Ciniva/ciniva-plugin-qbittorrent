# Ciniva plugin: qBittorrent

Adds a **Downloads** page to [Ciniva](https://github.com/Ciniva/ciniva): live progress, add magnet/URL/`.torrent`,
pause/resume, sequential ("download in order"), per-file priorities, Prowlarr search ranked by preferred quality,
languages and size, and "Find episodes" / "Find releases" on show, season and movie pages. When a download finishes it
asks Ciniva to rescan just that folder and notifies signed-in clients. While files download it reports which parts are
on disk, so Ciniva's library can play them and wait for the rest.

The plugin protocol is described in Ciniva's `docs/plugins.md`.

## Image

`ghcr.io/ciniva/ciniva-plugin-qbittorrent` (published by GitHub Actions for `vX.Y.Z` tags matching `Cargo.toml` as
`X.Y.Z`, `latest` and `sha-<short>`; run the workflow by hand to publish any branch as `sha-<short>`).

This repository also builds `ghcr.io/ciniva/qbittorrent` from [`qbittorrent/`](qbittorrent/Dockerfile): the static
qbittorrent-nox release, pinned and checksum-verified, running as 1000:1000 with no setuid binaries and a read-only
root filesystem. The two images are released together so the plugin always matches the qBittorrent API it talks to.
On first start (no `qBittorrent.conf` in `/config` yet) it writes a default config with the `.!qB` suffix for
incomplete files turned off, so Ciniva indexes episodes while they download. An existing config is never changed.

## Configuration

| Variable | Default | |
|---|---|---|
| `CINIVA_URL` | `http://ciniva:8484` | How the plugin reaches Ciniva |
| `CINIVA_PLUGIN_SECRET` | – | Ciniva's service key (or `CINIVA_PLUGIN_SECRET_FILE`) |
| `PLUGIN_URL` | `http://ciniva-qbittorrent:8090` | How Ciniva reaches the plugin |
| `QBIT_URL` | `http://qbittorrent-internal:8080` | qBittorrent Web UI; the plugin's network must be whitelisted (no login) |
| `PROWLARR_URL` | `http://prowlarr-internal:9696` | Prowlarr |
| `PROWLARR_API_KEY` | – | Or `PROWLARR_API_KEY_FILE`; can also be set in Ciniva's settings |
| `PATH_MAP` | `/data/storage/share/Downloads=/media/Downloads` | qBittorrent path prefix = the same folder as Ciniva sees it |

Run it on an internal-only Docker network with Ciniva, qBittorrent and Prowlarr; it needs no internet access. It runs as
an unprivileged user and works with a read-only root filesystem.
