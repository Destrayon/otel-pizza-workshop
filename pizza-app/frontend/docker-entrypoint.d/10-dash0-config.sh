#!/bin/sh
set -eu

target=/usr/share/nginx/html/dash0-config.js

if [ -z "${DASH0_WEBSITE_ENDPOINT:-}" ] || [ -z "${DASH0_WEBSITE_AUTH_TOKEN:-}" ]; then
  echo "dash0: website monitoring off (DASH0_WEBSITE_ENDPOINT / DASH0_WEBSITE_AUTH_TOKEN unset in pizza-app/.env)"
  printf 'window.DASH0_WEB_CONFIG = null;\n' > "$target"
  exit 0
fi

cat > "$target" <<EOF
window.DASH0_WEB_CONFIG = {
  environment: "${DASH0_ENVIRONMENT:-local}",
  endpoint: {
    url: "${DASH0_WEBSITE_ENDPOINT}",
    authToken: "${DASH0_WEBSITE_AUTH_TOKEN}",
    dataset: "${DASH0_DATASET:-default}"
  }
};
EOF

echo "dash0: website monitoring configured for ${DASH0_WEBSITE_ENDPOINT}"
