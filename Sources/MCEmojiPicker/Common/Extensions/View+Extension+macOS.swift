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
        self.popover(isPresented: isPresented, arrowEdge: .bottom) {
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
#endif
