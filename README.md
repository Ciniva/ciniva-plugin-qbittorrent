# Ciniva plugin: qBittorrent

Adds a **Downloads** page to [Ciniva](https://github.com/Ciniva/ciniva): live progress, add magnet/URL/`.torrent`,
pause/resume, sequential ("download in order"), per-file priorities, Prowlarr search ranked by preferred quality,
languages and size, and "Find episodes" / "Find releases" on show, season and movie pages. When a download finishes it
asks Ciniva to rescan just that folder and notifies signed-in clients.

The plugin protocol is described in Ciniva's `docs/plugins.md`.

## Image

`ghcr.io/ciniva/ciniva-plugin-qbittorrent` (built by GitHub Actions on every push to `main`; tags `latest`,
`sha-<short>`, and `X.Y.Z` for `vX.Y.Z` tags).

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
