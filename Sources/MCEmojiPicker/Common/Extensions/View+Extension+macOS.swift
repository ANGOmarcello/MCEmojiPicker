//
//  View+Extension+macOS.swift
//  MCEmojiPicker
//
//  Created by Angelo Cammalleri.
//  Passable additions are distributed under the repository MIT license.
//

#if os(macOS)
import SwiftUI
import AppKit

@available(macOS 13.0, *)
extension View {
    @ViewBuilder public func emojiPicker(
        isPresented: Binding<Bool>,
        selectedEmoji: Binding<String>,
        arrowDirection: MCPickerArrowDirection? = nil,
        customHeight: CGFloat? = nil,
        horizontalInset: CGFloat? = nil,
        isDismissAfterChoosing: Bool? = nil,
        selectedEmojiCategoryTintColor: NSColor? = nil,
        feedBackGeneratorStyle: MCEmojiFeedbackStyle? = nil
    ) -> some View {
        self.popover(isPresented: isPresented, arrowEdge: arrowDirection?.popoverArrowEdge) {
            MCEmojiPickerMacView(
                isPresented: isPresented,
                selectedEmoji: selectedEmoji,
                isDismissAfterChoosing: isDismissAfterChoosing ?? true,
                selectedEmojiCategoryTintColor: selectedEmojiCategoryTintColor.map { Color($0) }
            )
            .frame(maxHeight: customHeight ?? 360)
            .padding(.horizontal, horizontalInset ?? 0)
        }
    }
}

private extension MCPickerArrowDirection {
    var popoverArrowEdge: Edge {
        switch self {
        case .up:
            return .top
        case .down:
            return .bottom
        }
    }
}
#endif
