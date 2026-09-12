//
//  MCEmojiFeedbackStyle.swift
//  MCEmojiPicker
//
//  Created by Angelo Cammalleri.
//  Passable additions are distributed under the repository MIT license.
//

#if canImport(UIKit)
import UIKit

#if os(visionOS)
public enum MCEmojiFeedbackStyle {
}
#else
public typealias MCEmojiFeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle
#endif
#endif
