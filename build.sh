#/bin/bash
set -x

version="${1:-0.0.0-nfinite}"
skip_api="${2:-0}"

if (( $skip_api != 1 )); then
  # rebuild API
  echo "========== Rebuilding actual-app/api =========="
  pushd actual/packages/loot-core
  yarn build:api
  cp lib-dist/bundle.api* ../api/app
  cd ../api
  sed -i "s/\"version\": \".*\"/\"version\": \"$version\"/" package.json
popd
fi

# rebuild web
echo "========== Rebuilding actual-app desktop client =========="
pushd actual
./bin/package-browser
cd packages/desktop-client
sed -i "s/\"version\": \".*\"/\"version\": \"$version\"/" package.json
popd
