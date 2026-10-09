#!/usr/bin/env bash
# Build baikal-docker-hass and push it to the Zot registry as a multi-arch manifest.
#
# The cluster is mixed-architecture (amd64, arm64, armv7) and the Baikal job has
# no arch constraint, so all three are built. Non-native ones run under
# qemu-user-static emulation, which is why this takes minutes.
set -euo pipefail

REGISTRY="registry.visibilityspots.net"
PLATFORMS="linux/amd64,linux/arm64,linux/arm/v7"

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <version>   e.g. $0 0.12.1-1" >&2
  exit 1
fi

VERSION="$1"
IMAGE="${REGISTRY}/visibilityspots/baikal-docker-hass:${VERSION}"

echo "==> Building ${IMAGE} for ${PLATFORMS} …"
podman manifest rm "${IMAGE}" 2>/dev/null || true
podman build --platform "${PLATFORMS}" --build-arg "VERSION=${VERSION%-*}" --manifest "${IMAGE}" .

echo "==> Pushing to ${REGISTRY} …"
podman manifest push --all "${IMAGE}" "docker://${IMAGE}"

echo "==> Done: ${IMAGE}"
podman manifest inspect "${IMAGE}" |
  python3 -c 'import sys,json; print("    platforms:", [m["platform"]["architecture"] + m["platform"].get("variant", "") for m in json.load(sys.stdin).get("manifests", [])])'
echo "    Next: bump the tag in jobs/stable/services/baikal.hcl and 'nomad job run' it."
