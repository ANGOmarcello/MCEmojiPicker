#if os(macOS)
import SwiftUI

struct MCEmojiPickerMacView: View {
    @Binding var isPresented: Bool
    @Binding var selectedEmoji: String
    let isDismissAfterChoosing: Bool
    let selectedEmojiCategoryTintColor: Color?

    @State private var query: String = ""
    @State private var categories: [MCEmojiCategory] = MCUnicodeManager().getEmojisForCurrentIOSVersion()
    @State private var selectedCategoryType: MCEmojiCategoryType?

    private let columns = [
        GridItem(.adaptive(minimum: 28), spacing: 8)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Search emoji", text: $query)
                .textFieldStyle(.roundedBorder)

            categoryPicker

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(visibleCategories.enumerated(), id: \.element.type) { _, category in
                        if category.emojis.isEmpty == false {
                            Text(category.categoryName)
                                .font(.caption)
                                .bold()
                                .foregroundStyle(selectedEmojiCategoryTintColor ?? .secondary)

                            LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                                ForEach(category.emojis.indices, id: \.self) { index in
                                    let emoji = category.emojis[index]
                                    Button {
                                        selectedEmoji = emoji.string
                                        emoji.incrementUsageCount()
                                        if isDismissAfterChoosing {
                                            isPresented = false
                                        }
                                    } label: {
                                        Text(emoji.string)
                                            .font(.system(size: 20))
                                            .frame(width: 28, height: 28)
                                            .contentShape(.rect)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
            .frame(minHeight: 240, maxHeight: 320)
        }
        .padding(12)
        .frame(width: 320)
        .onAppear {
            if selectedCategoryType == nil {
                selectedCategoryType = nonEmptyCategories.first?.type
            }
        }
    }

    private var visibleCategories: [MCEmojiCategory] {
        let filtered = filteredCategories
        guard query.isEmpty, let selectedCategoryType else { return filtered }
        if let match = filtered.first(where: { $0.type == selectedCategoryType }) {
            return [match]
        }
        return filtered
    }

    private var filteredCategories: [MCEmojiCategory] {
        guard query.isEmpty == false else { return categories }
        let lowered = query.lowercased()
        return categories.compactMap { category in
            let emojis = category.emojis.filter { emoji in
                emoji.searchKey.localizedStandardContains(lowered)
            }
            if emojis.isEmpty { return nil }
            return MCEmojiCategory(type: category.type, emojis: emojis)
        }
    }

    private var nonEmptyCategories: [MCEmojiCategory] {
        categories.filter { $0.emojis.isEmpty == false }
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(nonEmptyCategories, id: \.type) { category in
                    Button {
                        selectedCategoryType = category.type
                    } label: {
                        Text(category.categoryName)
                            .font(.caption)
                            .bold()
                            .lineLimit(1)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(categoryBackground(for: category.type))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .strokeBorder(categoryBorder(for: category.type), lineWidth: 1)
                            )
                            .foregroundStyle(categoryForeground(for: category.type))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    private func categoryBackground(for type: MCEmojiCategoryType) -> Color {
        selectedCategoryType == type ? Color.accentColor.opacity(0.15) : Color.primary.opacity(0.04)
    }

    private func categoryBorder(for type: MCEmojiCategoryType) -> Color {
        selectedCategoryType == type ? Color.accentColor : Color.primary.opacity(0.12)
    }

    private func categoryForeground(for type: MCEmojiCategoryType) -> Color {
        selectedCategoryType == type ? Color.accentColor : Color.primary
    }
}
#endif
