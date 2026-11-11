# google_maps_flutter (Sourcya fork)

The `google_maps_flutter` federated plugin, forked from
[flutter/packages](https://github.com/flutter/packages) with the changes Sourcya apps need. This
repo holds only these packages, so a git dependency downloads a few MB instead of all of
flutter/packages.

| Package | Role |
|---|---|
| `google_maps_flutter` | App-facing package |
| `google_maps_flutter_platform_interface` | Platform interface |
| `google_maps_flutter_android` | Android implementation |
| `google_maps_flutter_ios`, `_ios_sdk9`, `_ios_sdk10`, `_ios_shared_code` | iOS implementations |
| `google_maps_flutter_web` | Web implementation |

## What differs from upstream

- Cluster support with cluster-tap and cluster-update callbacks.
- Marker updates that keep the icon when only the position or rotation changes: Android and iOS
  skip re-applying an unchanged icon, and web keeps one image URL per icon so a marker that moves
  every frame does not blink.
- Web marker rotation.

## Using it

Depend on `google_maps_flutter` (the federated packages it needs resolve from this repo too):

```yaml
dependencies:
  google_maps_flutter:
    git:
      url: https://github.com/sourcya/google_maps_flutter.git
      path: google_maps_flutter
      ref: main
```

The repo is public, so no credentials are needed. The package paths are at the repo root
(`google_maps_flutter`, `google_maps_flutter_android`, ...), not under `packages/`.

## Working on it

- Change code on a branch, and open a pull request into `main`.
- Native tests: Android with `./gradlew :google_maps_flutter_android:testDebugUnitTest` from
  `google_maps_flutter_android/example/android`; iOS with `xcodebuild test` on the example
  workspace; web tests are integration tests under `google_maps_flutter_web/example`.
- To try a change in an app, add a `dependency_overrides` entry with a local `path:` and do not
  commit it.
- The packages' own `pubspec.yaml` files point at this repo with `ref: main`. When you cut a
  branch to test a change through git dependencies, point those refs at the branch and put them
  back to `main` before merging.

## Upstream

History is preserved from flutter/packages (`packages/google_maps_flutter`), so upstream changes
can be merged with `git remote add upstream <flutter/packages>` and a subtree merge. The code is
under the same BSD 3-Clause license as flutter/packages (see `LICENSE`); the packages keep their
upstream `LICENSE` and `AUTHORS` files.
