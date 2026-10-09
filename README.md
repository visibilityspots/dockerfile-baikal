# baikal-docker-hass

A ready-to-go [Baikal](https://sabre.io/baikal/) server that includes a
[fix](https://github.com/sabre-io/dav/issues/1318) so Home Assistant can read its
calendars.

Fork of the archived
[MrAlucardDante/baikal-docker-hass](https://github.com/MrAlucardDante/baikal-docker-hass),
which stopped at Baikal 0.10.1.

## What changed in this fork

- **Baikal is downloaded from the upstream release** (checksum pinned) instead of
  taken from `ckulka/baikal`, whose newest version is also 0.10.1. The runtime
  (nginx + php-fpm 8.2, entrypoint scripts) still comes from `ckulka/baikal`,
  pinned by digest.
- **The Home Assistant fix is a one-hunk patch**
  (`home-assistant-timezone.patch`) instead of a whole copied `Plugin.php`. A
  sabre/dav update can then no longer be silently reverted: when the hunk stops
  applying, the build fails.

## Build

```bash
./build.sh 0.12.1-1   # multi-arch, pushed to registry.visibilityspots.net
```

## Upgrading an existing install

When the Baikal version changes, DAV requests redirect to
`/admin/install/` until the upgrade wizard has run once. Back up
`Specific/db/db.sqlite` first, then open `/admin/install/` and start the upgrade.

For everything else (volumes, environment variables), see
[ckulka/baikal-docker](https://github.com/ckulka/baikal-docker).
