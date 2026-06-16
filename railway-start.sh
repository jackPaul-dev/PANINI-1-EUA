#!/bin/sh
# Descobre o caminho real do dist neste servidor
DIST="$(realpath artifacts/api-server/dist)"
REPLIT_PATH="/home/runner/workspace/artifacts/api-server/dist"

echo "Patching dist paths: $REPLIT_PATH -> $DIST"
for f in "$DIST"/*.mjs; do
  sed -i "s|$REPLIT_PATH|$DIST|g" "$f"
done

echo "Running DB migrations..."
pnpm --filter @workspace/db run push-force 2>&1 || echo "Migration step skipped"

echo "Starting server from $DIST/index.mjs"
exec node --enable-source-maps "$DIST/index.mjs"
