# Fork provenance and maintenance

This fork keeps MCEmojiPicker as a focused emoji library. AppToolkit owns any
composition with images, SF Symbols, Photos, Files, or camera. Product routes,
image preparation, cropping/export limits, persistence, upload policy, analytics,
privacy usage descriptions, and web-image attribution belong to consuming apps.

## Upstream and local history

- Upstream: https://github.com/izyumkin/MCEmojiPicker
- Original author and license: Ivan Izyumkin, MIT. Preserve `LICENSE` and the
  upstream copyright/license headers in source distributions and substantial
  copies. Consumer acknowledgement generation must include this transitive
  dependency and its original attribution.
- Passable's last remote dependency was tag `1.2.5`, commit
  `e5b3ed359b04370287366a7c15ffa7013cdd4eec`.
- This fork branches from upstream `main` at
  `4ede163a7e06e1526d230e514bd69c1c7b1910ac`; that commit only corrects the
  CocoaPods version after `1.2.5`. All upstream commits are retained.
- Passable initially copied the package in
  `d5fc3c98f431794ea353eb6ea6388c678d8f4abd` (2026-02-27). Every copied file
  matched `1.2.5` except seven lines that clear category controls before
  rebuilding them. That initial fix is ported separately.
- Subsequent ports are grouped into visionOS support/category contrast, native
  macOS emoji selection/category browsing, and adaptive popover placement.
  Each commit lists the originating Passable commits. Intermediate macOS
  experiments are consolidated into the resulting working implementation.
- Upstream examples, generator inputs, emoji JSON, translations, and original
  license remain intact. No Passable app code or private repository history is
  included. Passable's stale `1.2.3` podspec is not copied over upstream's `1.2.5`.

## Compatibility

The package supports iOS 13+, macOS 11+, and visionOS 1+. Its native macOS picker
requires macOS 13 and is explicitly availability-gated; the library may still
be linked by macOS 11 clients. iOS retains UIKit presentation and the original
skin-tone UI. visionOS excludes unavailable haptics and orientation APIs.
macOS uses a SwiftUI popover with search, category navigation, empty-category
filtering, selection binding, and shared usage persistence. Default popover
placement permits either vertical direction; explicit direction remains
respected.

An AppToolkit dependency should be limited to iOS, macOS, and visionOS. Do not
make watchOS or tvOS targets import this picker. Keep `MCEmojiPicker` as the
module/product name for source compatibility. Consumers must resolve one
versioned remote copy, not combine this fork with the vendored Passable copy or
an independent upstream dependency of the same package identity.

## Existing behavior and limits

The first fork release preserves the shipped Passable picker. It does not
claim feature parity between platforms: the macOS picker has search while the
iOS picker retains upstream's category/skin-tone UI. The catalog remains the
upstream Unicode 15-era data. The new macOS search placeholder is inherited
English-only text; adding localization belongs to a focused follow-up. Existing
UserDefaults usage and skin-tone keys are preserved so the migration does not
erase prior choices. A future configurable store requires explicit migration.
The upstream limitation for two-part skin-tone emoji remains documented in the
README. Builds and unit tests do not prove visual behavior or physical-device
camera functionality in an AppToolkit composition.

## Updating and releasing

1. Fetch `upstream`, inspect its changes, and merge/rebase without replacing
   original history or dropping the MIT attribution.
2. Keep emoji-library changes separate from AppToolkit composition and app
   product logic. Add focused regression tests for changed behavior.
3. Run `swift test` and `git diff --check`. Compile the library for generic iOS
   Simulator and visionOS Simulator destinations, and macOS. For UI changes,
   inspect real iOS/macOS hosts, repeat open/dismiss, category selection,
   searching, emoji/skin-tone selection, and explicit/automatic placement.
4. Publish a fork release tag only after review and validation. Verify the
   remote tag points at the tested commit before updating AppToolkit.
5. Release AppToolkit with the versioned fork dependency. Resolve each consumer
   from remote, inspect `Package.resolved`, and build affected platforms before
   deleting its vendored package or duplicate presentation code.
6. Keep this fork's public README/package metadata distinct from upstream's
   CocoaPods release. Do not publish under upstream's CocoaPods identity.
