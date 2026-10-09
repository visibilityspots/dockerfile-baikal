## [v0.12.1-1] - 2026-10-09
### :boom: BREAKING CHANGES
- due to [`1fdf24b`](https://github.com/visibilityspots/dockerfile-baikal/commit/1fdf24b88e92ab28506c1e9571d3815a4a0ab8e6) - run on Alpine with php-fpm 8.4 instead of ckulka's Debian runtime *(commit by [@visibilityspots](https://github.com/visibilityspots))*:

  ckulka's environment switches (APPLY_HOME_ASSISTANT_FIX,  
  BAIKAL_SKIP_CHOWN, msmtp) are gone; php-fpm runs as the baikal user.


### :sparkles: New Features
- [`1fdf24b`](https://github.com/visibilityspots/dockerfile-baikal/commit/1fdf24b88e92ab28506c1e9571d3815a4a0ab8e6) - run on Alpine with php-fpm 8.4 instead of ckulka's Debian runtime *(commit by [@visibilityspots](https://github.com/visibilityspots))*

## [v0.12.1] - 2026-10-09
### :boom: BREAKING CHANGES
- due to [`ec4bb2e`](https://github.com/visibilityspots/dockerfile-baikal/commit/ec4bb2e834b5b637f46d2765a51f443b46ccb3d4) - build Baikal 0.12.1 from the upstream release *(commit by [@visibilityspots](https://github.com/visibilityspots))*:

  an existing 0.10.1 install redirects DAV requests to the  
  upgrade wizard at /admin/install/ until it has been run once.


### :sparkles: New Features
- [`ec4bb2e`](https://github.com/visibilityspots/dockerfile-baikal/commit/ec4bb2e834b5b637f46d2765a51f443b46ccb3d4) - build Baikal 0.12.1 from the upstream release *(commit by [@visibilityspots](https://github.com/visibilityspots))*

### :wrench: Chores
- [`fb26920`](https://github.com/visibilityspots/dockerfile-baikal/commit/fb269205a83eb2efa1f50a7670a878b274491fb6) - **deps**: update actions/checkout action to v6 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*
- [`8359916`](https://github.com/visibilityspots/dockerfile-baikal/commit/8359916b3d586d89542926d1e354bb706554761a) - **deps**: update docker/login-action action to v4 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*
- [`0592865`](https://github.com/visibilityspots/dockerfile-baikal/commit/0592865a684489f524f036110d3814ae640a099d) - **deps**: update docker/setup-qemu-action action to v4 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*
- [`0758de2`](https://github.com/visibilityspots/dockerfile-baikal/commit/0758de2a5fc816a7d01a68de93fa7dbf3d299404) - **deps**: update docker/setup-buildx-action action to v4 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*
- [`5ce1f78`](https://github.com/visibilityspots/dockerfile-baikal/commit/5ce1f7877a84f7bf0309037e22007802c77d6038) - **deps**: update docker/build-push-action action to v7 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*
- [`be01234`](https://github.com/visibilityspots/dockerfile-baikal/commit/be012344560960878f357cae123942c8c5f6fb8b) - **deps**: update docker/metadata-action action to v6 *(commit by [@renovate[bot]](https://github.com/apps/renovate))*


## 0.10.1 (2024-11-19)

### Fix

- **postgres**: added php postgres driver

## 0.10.0 (2024-11-18)

### Feat

- **deps**: update ckulka/baikal docker tag to v0.10.1

## 0.9.5 (2024-04-26)

### Fix

- **renovate**: update commit prefix

## 0.9.4 (2023-12-31)

### Fix

- bump to 0.9.4
- **docker**: wrong order in entrypoint folder

## 0.9.3+msmtp (2023-10-31)

## 0.9.3 (2023-09-18)

### Fix

- https://github.com/sabre-io/dav/issues/1318
[v0.12.1]: https://github.com/visibilityspots/dockerfile-baikal/compare/0.10.1...v0.12.1
[v0.12.1-1]: https://github.com/visibilityspots/dockerfile-baikal/compare/v0.12.1...v0.12.1-1
