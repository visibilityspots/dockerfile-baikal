# dockerfile-baikal

A ready-to-go [Baikal](https://sabre.io/baikal/) CalDAV/CardDAV server, published as
[`visibilityspots/baikal`](https://hub.docker.com/r/visibilityspots/baikal), with a
fix so Home Assistant can read its calendars
([sabre-io/dav#1318](https://github.com/sabre-io/dav/issues/1318)).

Forked from the archived
[MrAlucardDante/baikal-docker-hass](https://github.com/MrAlucardDante/baikal-docker-hass),
which stopped at Baikal 0.10.1.

## How the image is built

- **Baikal comes from the upstream release zip**, its checksum pinned in the
  `Dockerfile`, and runs on **Alpine** with nginx and php-fpm 8.4. `ckulka/baikal`
  stops at 0.10.1 and its Debian runtime carried ~180 HIGH/CRITICAL findings, so
  nothing of it is used any more.
- **php-fpm runs as uid 101** (`baikal`), the owner of data written by the
  earlier Debian-based images, so existing volumes keep working without a chown.
- **The Home Assistant fix is a patch** (`home-assistant-timezone.patch`), not a
  copied `Plugin.php`. The `calendar-timezone` property is read both as a plain
  name (`Europe/Paris`, what Home Assistant and Baikal's admin store) and as the
  RFC 4791 `VCALENDAR`. When a sabre/dav update makes the patch stop applying,
  the build fails instead of silently reverting that update.

## Releasing

CI runs on a tag, through the shared
[github-workflows](https://github.com/visibilityspots/github-workflows): build,
`dgoss` test against `goss.yaml`, multi-arch push to Docker Hub
(amd64, arm/v7, arm64), GitHub release.

A new Baikal version means updating `VERSION` and `SHA256` in the `Dockerfile`
**and** the version string in `goss.yaml`.

## Upgrading an existing install

When the Baikal version changes, DAV requests redirect to `/admin/install/` until
the upgrade wizard has run once. Back up `Specific/db/db.sqlite` first, then open
`/admin/install/` and start the upgrade.

The volumes are `/var/www/baikal/config` and `/var/www/baikal/Specific`.
