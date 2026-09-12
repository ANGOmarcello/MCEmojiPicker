# Platform support

The current Swift package source provides UIKit presentation on iOS and
visionOS and a native SwiftUI picker on macOS. It preserves the emoji catalog,
category translations, and existing usage and skin-tone preference keys.

## Compatibility

| Platform | Minimum OS | Presentation | Search | Skin-tone chooser |
| --- | --- | --- | --- | --- |
| iOS | 13 | UIKit controller or SwiftUI modifier | No | Yes |
| macOS | 13 for the picker UI | Native SwiftUI popover | Yes | No |
| visionOS | 1 | UIKit controller or SwiftUI modifier | No | Yes |

The package manifest requires Swift tools 5.10. A macOS 11+ app may link the
package, but it must availability-guard calls to the macOS 13+ picker API.
The additional platforms use Swift Package Manager; the existing CocoaPods
specification covers iOS.

## SwiftUI selection

Use the same modifier on each supported platform:

```swift
Button(selectedEmoji) {
    isPresented = true
}
.emojiPicker(
    isPresented: $isPresented,
    selectedEmoji: $selectedEmoji
)
```

`selectedEmoji` is updated on selection. `isDismissAfterChoosing` defaults to
`true`; set it to `false` to keep the picker open. On macOS, the picker offers
search and category navigation, omits empty categories, and records selections
in the existing frequently used emoji store. Search uses English metadata;
the search-field placeholder is currently English.

## Presentation and customization

Leaving `arrowDirection` unspecified lets the system choose vertical popover
placement. Passing `.up` or `.down` selects an explicit arrow direction. On the
UIKit controller, assigning `arrowDirection` sets
`automaticallyAdjustsArrowDirection` to `false`; set it back to `true` to
restore automatic placement.

- `customHeight` requests a height subject to available presentation space.
- `horizontalInset` adjusts the UIKit source-view inset; on macOS it adds
  horizontal content padding.
- `selectedEmojiCategoryTintColor` changes the selected category tint on UIKit
  and category heading tint on macOS. macOS category tabs use the accent color.
- Haptic feedback is iOS-only. The UIKit controller defaults to `.light`;
  assigning `nil` disables it. The SwiftUI modifier retains the default when
  its feedback argument is omitted or `nil`.

The UIKit category bar uses a material background and semantic label colors.
Repeated category setup clears existing controls before rebuilding them.

## Catalog limitations

The bundled catalog remains Unicode 15-era data with inherited OS-version
filtering. A visionOS-specific version mapping is still needed: early
visionOS versions can receive a reduced catalog from the inherited iOS table.
The two-part skin-tone emoji limitation described in the README also remains.

## Verification

Run `swift test` for the arrow-direction regression tests and build the Swift
package for macOS, iOS Simulator, and visionOS Simulator. In host apps, verify
repeated open/dismiss, category navigation, selection bindings, automatic and
explicit placement, macOS search, and the iOS/visionOS skin-tone chooser.
Check each platform's behavior independently.
