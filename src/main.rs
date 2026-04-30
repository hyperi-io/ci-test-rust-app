// SPDX-License-Identifier: FSL-1.1-ALv2
// Copyright (c) 2026 HYPERI PTY LIMITED

//! ci-test-rust-app — Rust application variant for the hyperi-ci test
//! matrix. Exercises three things in one CI run:
//!
//! 1. Native C/C++ dep compilation + aarch64 cross-compile (rdkafka /
//!    librdkafka via cmake-build).
//! 2. The hyperi-rustlib install path — proves the standard logger /
//!    cli features resolve, link, and load at runtime.
//! 3. The hyperi-ci container custom-mode build — Dockerfile detected,
//!    multi-arch buildx, GHCR push.

use rdkafka::util::get_rdkafka_version;

fn main() {
    // Initialise rustlib's logger so the binary doesn't link the
    // logger feature without exercising it. Even a single emit catches
    // ABI / linkage regressions early.
    let _ = hyperi_rustlib::logger::setup_default();

    let (version_int, version_str) = get_rdkafka_version();
    println!(
        "ci-test-rust-app v{} (librdkafka {} / 0x{:08x})",
        env!("CARGO_PKG_VERSION"),
        version_str,
        version_int,
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn librdkafka_version_is_valid() {
        let (version_int, version_str) = get_rdkafka_version();
        assert!(version_int > 0, "librdkafka version int should be > 0");
        assert!(
            !version_str.is_empty(),
            "librdkafka version string should not be empty"
        );
    }

    #[test]
    fn rustlib_logger_setup_is_callable() {
        // Don't unwrap — the logger may already be initialised by a
        // sibling test in the same process. We're just checking that
        // the symbol is reachable + the feature is wired correctly.
        let _ = hyperi_rustlib::logger::setup_default();
    }
}
