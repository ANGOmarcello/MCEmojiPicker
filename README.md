# MCEmojiPicker · cammalleri.dev fork

Emoji picker popovers for **iOS, macOS, and visionOS**, based on
[Ivan Izyumkin's MCEmojiPicker](https://github.com/izyumkin/MCEmojiPicker).
This maintained fork brings the improvements developed in **Passable** back
into a reusable Swift package, with the original history and MIT attribution
preserved.

## What this fork adds

| Addition | What changed from upstream |
| --- | --- |
| **Native macOS picker** | A SwiftUI popover with search, category navigation, empty-category filtering, selection bindings, and the existing frequently used emoji store. |
| **visionOS support** | Package and UIKit/SwiftUI support for visionOS, with unavailable haptics and orientation APIs excluded. |
| **Adaptive popover placement** | The picker can open above or below its anchor, allowing the system to use the available space. Explicit arrow-direction choices remain supported. |
| **Category-bar contrast** | A material-backed category bar and semantic label colors for category icons and headings. |
| **Safe repeated setup** | Existing category controls are cleared before rebuilding, preventing duplicated controls when setup runs again. |

The iOS emoji grid, category navigation, skin-tone picker, frequently used
emoji, bundled catalog, and existing translations originate in upstream.
Passable's changes were ported as focused commits on top of upstream
`4ede163a`, following its `1.2.5` release. The first fork release is **1.2.6**.
See [fork provenance and maintenance](Documentation/ForkMaintenance.md) for
commit origins, compatibility details, and the update process.

This package owns emoji selection. AppToolkit combines it with image,
SF Symbol, Photos, Files, and camera selection; Passable supplies its editor,
expanding camera sheet, design tokens, and image-processing policy.

## Apps using this fork

**[Passable](https://apps.apple.com/app/id6756588944)** — create custom Apple
Wallet passes. These additions originated in Passable's emoji picker, which
now integrates this fork through AppToolkit's media picker components for
avatar and logo emoji selection.

Using this fork in your app? Open a pull request to add it here.

<details>
<summary>Apps showcased by the original MCEmojiPicker project</summary>

The following showcase is preserved from upstream; these apps are listed as
users of the original library, without implying adoption of this fork.

<p float="left">
    <a href="https://apps.apple.com/app/id1500111859"><img src="https://github.com/user-attachments/assets/bc8b8235-b848-43ef-a143-fbce80c195d3" height="65"></a>
    <a href="https://apps.apple.com/app/id6450279059"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/270146ff-d3e7-4c46-97c2-2c796e6bd78d" height="65"></a>
    <a href="https://apps.apple.com/app/id6444636956"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/ecae445c-1683-422b-a0e7-8dbaeac2eb18" height="65"></a>
    <a href="https://github.com/Housemates-Mobile-App/housemates_mobileapp"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/05a8651a-c6fb-419e-9bdc-aa7d68b53af7" height="65"></a>
    <a href="https://github.com/RedEagle-dh/Quantify"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/bfa48cc4-c901-4235-8bfc-f5fb0fa22279" height="65"></a>
    <a href="https://github.com/norbusonam/routine"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/97a5b6ee-0cff-4839-894e-5c2d08daca3a" height="65"></a>
    <a href="https://github.com/bapaws/clock"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/7a615b02-43a2-4557-bfbd-7f40841ac508" height="65"></a>
    <a href="https://github.com/fn1y/Habitrack"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/0b634a00-257f-4e9d-93b0-8f8a2c0d335d" height="65"></a>
    <a href="https://github.com/honzachalupa/SymptomsTracker"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/836c08c8-7e60-4403-ad0a-fffaed926d15" height="65"></a>
    <a href="https://github.com/savoirfairelinux/jami-client-ios"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/b2e00327-7c13-407b-8c43-3c189504c3c5" height="65"></a>
    <a href="https://github.com/deltachat/deltachat-ios"><img src="https://github.com/izyumkin/MCEmojiPicker/assets/50948518/6322e6cf-71d4-4f37-893c-44277b277517" height="65"></a>
    <a href="https://apps.apple.com/app/id6465843931"><img src="https://github.com/user-attachments/assets/efc4408b-f716-4773-b255-d267c2fb5bf7" height="65"></a>
    <a href="https://apps.apple.com/app/id6499061841"><img src="https://github.com/user-attachments/assets/13bab9ec-7c73-4a3b-bf52-c5c5d3ce14b0" height="65"></a>
    <a href="https://apps.apple.com/app/id6476229386"><img src="https://github.com/user-attachments/assets/fefc767e-5d07-4bb7-b83a-b190e2188ddb" height="65"></a>
</p>

</details>

## Requirements

A Swift toolchain supporting **Swift tools 5.10** is required to load the
package manifest.

| Platform | Supported picker |
| --- | --- |
| iOS 13+ | UIKit picker and SwiftUI modifier |
| macOS 13+ | Native SwiftUI picker with search |
| visionOS 1+ | UIKit-backed picker and SwiftUI modifier |

The package can also be linked by macOS 11+ clients; the native macOS picker
API is availability-gated to macOS 13+. See the platform differences below
before assuming the same features on every platform.

## Installation

Add this repository in Xcode's package dependencies and link the
`MCEmojiPicker` product:

```text
https://github.com/ANGOmarcello/MCEmojiPicker.git
```

Or add it to `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/ANGOmarcello/MCEmojiPicker.git",
        from: "1.2.6"
    )
]
```

Use one copy of `MCEmojiPicker` in the dependency graph. Replace an upstream
or vendored copy when adopting this fork. The module name remains
`MCEmojiPicker`, so existing imports continue to work.

Fork releases are distributed through Swift Package Manager. The
[CocoaPods package](https://cocoapods.org/pods/MCEmojiPicker) belongs to the
original upstream project and does not install this fork's additions.

## SwiftUI

The same modifier is available on iOS, macOS, and visionOS at the deployment
versions listed above:

```swift
import SwiftUI
import MCEmojiPicker

struct EmojiButton: View {
    @State private var isPresented = false
    @State private var selectedEmoji = "😀"

    var body: some View {
        Button(selectedEmoji) {
            isPresented = true
        }
        .emojiPicker(
            isPresented: $isPresented,
            selectedEmoji: $selectedEmoji
        )
    }
}
```

The picker updates `selectedEmoji` and dismisses after selection by default.
Leave `arrowDirection` unspecified for automatic placement, or pass `.up`
or `.down` for an explicit arrow direction.

## UIKit

On iOS and visionOS, anchor the picker to a source view and receive the choice
through `MCEmojiPickerDelegate`:

```swift
@objc private func selectEmojiAction(_ sender: UIButton) {
    let picker = MCEmojiPickerViewController()
    picker.delegate = self
    picker.sourceView = sender
    present(picker, animated: true)
}

extension ViewController: MCEmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        emojiButton.setTitle(emoji, for: .normal)
    }
}
```

## Customization

The SwiftUI modifier and UIKit controller support these options:

| Option | Behavior |
| --- | --- |
| `arrowDirection` | Explicit `.up` or `.down` arrow direction. Omit it to allow automatic vertical placement. |
| `customHeight` | Requested picker height; available space can constrain the presentation. |
| `horizontalInset` | Inset from the UIKit source view, or horizontal content padding on macOS. |
| `isDismissAfterChoosing` | Whether selection closes the picker; defaults to `true`. |
| `selectedEmojiCategoryTintColor` | Selected category tint on UIKit; category heading tint on macOS. |
| `feedBackGeneratorStyle` | iOS haptic feedback style. Haptics are unavailable on macOS and visionOS. |

Assigning `arrowDirection` on the UIKit controller disables automatic
placement. To restore it:

```swift
picker.automaticallyAdjustsArrowDirection = true
```

To disable iOS haptics on the UIKit controller, set
`picker.feedBackGeneratorStyle = nil`. In the SwiftUI modifier, omitting that
argument or passing `nil` retains the default feedback behavior.

## Platform differences and limitations

- **Search is currently macOS-only**, using the existing English search
  metadata. Its search-field placeholder is also English.
- **Skin-tone selection uses the upstream iOS/visionOS UI.** The native macOS
  picker does not yet provide a skin-tone chooser.
- The upstream limitation for two-part skin-tone emoji remains: single-tone
  handshake variants such as 🤝🏻 work; mixed-tone sequences such as 🫱🏿‍🫲🏻 are
  not supported. See the [upstream discussion](https://github.com/izyumkin/MCEmojiPicker/discussions/10).
- The bundled catalog remains the upstream Unicode 15-era data, with inherited
  OS-version filtering. A visionOS-specific version mapping is still needed;
  early visionOS versions can receive a reduced catalog from the inherited
  iOS version table.
- Existing localized category strings and usage/skin-tone preference keys are
  preserved. Adopting the fork keeps the same preference storage conventions.

## Credits and license

Original library by **Ivan Izyumkin**. Fork maintained by **Angelo Cammalleri**
for cammalleri.dev, incorporating the additions developed in Passable.
Distributed under the original [MIT license](LICENSE); preserve the copyright
and license notice in redistributions and app acknowledgements.

For the story behind the original iOS implementation, see Ivan's articles on
[Medium](https://medium.com/@izzyumkin/an-emoji-selection-element-aka-emojipicker-for-ios-like-in-macos-e2fa022b80af)
and [Habr](https://habr.com/ru/post/716194/).
