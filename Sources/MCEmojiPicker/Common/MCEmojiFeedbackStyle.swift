#if canImport(UIKit)
import UIKit

#if os(visionOS)
public enum MCEmojiFeedbackStyle {
}
#else
public typealias MCEmojiFeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle
#endif
#endif
