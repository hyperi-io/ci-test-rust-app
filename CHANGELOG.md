# Changelog

Rendered by CI and committed back at the end of a release -- do not edit by
hand. Release notes also appear on the GitHub Releases page, one per tag.

## [1.0.4](https://github.com/hyperi-io/ci-test-rust-app/compare/v1.0.3...v1.0.4) (2026-11-16)

### Bug Fixes

* **ci:** add a runner-mode dispatch input ([71bce39](https://github.com/hyperi-io/ci-test-rust-app/commit/71bce39403271cab7a4c9633d347996cca384b78))
* **fixture:** restore GA releases from main ([fcc5bfd](https://github.com/hyperi-io/ci-test-rust-app/commit/fcc5bfda6a2d5fdb0a097cd613405fe50ad49db7))

## [1.0.3](https://github.com/hyperi-io/ci-test-rust-app/compare/v1.0.2...v1.0.3) (2026-11-13)

### Bug Fixes

* **fixture:** drop the five-minute CI claim ([4d1e0f6](https://github.com/hyperi-io/ci-test-rust-app/commit/4d1e0f6b8670f9a4bcb82ec8f7c5cf6f46e3b94e))

## [1.0.2](https://github.com/hyperi-io/ci-test-rust-app/compare/v1.0.1...v1.0.2) (2026-11-13)

### What's Changed
* fix: modernise dispatch to from-head shape by @catinspace-au in https://github.com/hyperi-io/ci-test-rust-app/pull/3
* fix: enable branch-mode dev-push by @catinspace-au in https://github.com/hyperi-io/ci-test-rust-app/pull/4
* fix(release): add the VERSION file the tag step requires by @catinspace-au in https://github.com/hyperi-io/ci-test-rust-app/pull/5
* fix(deps): swap the archived hyperi-rustlib for scalo by @catinspace-au in https://github.com/hyperi-io/ci-test-rust-app/pull/8
* fix(deps): update Rust crate scalo to >=2.12.3, <3 by @renovate[bot] in https://github.com/hyperi-io/ci-test-rust-app/pull/9
* fix: rename legacy publish: config key to release:, refresh comment by @catinspace-au in https://github.com/hyperi-io/ci-test-rust-app/pull/66

### New Contributors
* @catinspace-au made their first contribution in https://github.com/hyperi-io/ci-test-rust-app/pull/3
* @renovate[bot] made their first contribution in https://github.com/hyperi-io/ci-test-rust-app/pull/9

## [1.0.1](https://github.com/hyperi-io/ci-test-rust-app/compare/v1.0.0...v1.0.1) (2026-04-30)


### Bug Fixes

* refresh module doc to reflect dynamic-linking and runtime Dockerfile ([7d80f0d](https://github.com/hyperi-io/ci-test-rust-app/commit/7d80f0daad582d9c1772a9d20875ded5166cd2e9))

# 1.0.0 (2026-04-30)


### Bug Fixes

* canary on hyperi-ci v1.13.0 container pipeline (GHCR via target=oss) ([b2d0cbb](https://github.com/hyperi-io/ci-test-rust-app/commit/b2d0cbb2294a7fbc6ed69e63a1dd736bf83c1d09))
* **dockerfile:** add native deps for librdkafka cmake-build (curl, sasl2, zstd, lz4, snappy, zlib) ([ac0d94a](https://github.com/hyperi-io/ci-test-rust-app/commit/ac0d94a1c6b0f12c6e7a7768ecf68c02c3384d22))
* greenfield as ci-test-rust-app — hyperi-rustlib + canonical name ([556e818](https://github.com/hyperi-io/ci-test-rust-app/commit/556e8186df90376b470976fcf0d22d76a26715e8))
* runtime-only Dockerfile + dynamic-linking rdkafka (mirrors dfe-loader) ([73743a4](https://github.com/hyperi-io/ci-test-rust-app/commit/73743a43956439d2679412fdcd32d4d04ec5db1b))
* trigger CI on all branches and add workflow_dispatch ([5ceb9cc](https://github.com/hyperi-io/ci-test-rust-app/commit/5ceb9cc38bf3d46e268eff597750657d3271b3cc))


### Features

* initial ci-test-rust-minimal project ([2a68c7a](https://github.com/hyperi-io/ci-test-rust-app/commit/2a68c7ab0f4b7781c9bde6b9e48ca36e26898c9f))
