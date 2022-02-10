
import SwiftUI

enum StyleGuide {
	enum Color {
		enum Text {}
	}
	enum Font {}
}

extension StyleGuide.Color {
	
	// 11, 19, 43
	static let primary = Color(red: 11/255, green: 19/255, blue: 43/255)
	
	// 28, 37, 65
	static let secondary = Color(red: 28/255, green: 37/255, blue: 65/255)
	
	// 58, 80, 107
	static let tertiary = Color(red: 58/255, green: 80/255, blue: 107/255)
	
	// 238, 238, 238
	static let background = Color(red: 238/255, green: 238/255, blue: 238/255)
	
	// 91, 192, 190
	static let accent = Color(red: 91/255, green: 192/255, blue: 190/255)

	// 111, 255, 233
	static let highlight = Color(red: 111/255, green: 255/255, blue: 233/255)

}

extension StyleGuide.Color.Text {
	
	static let primary = Color.primary
	static let secondary = Color.gray
	static let light = Color.white
	
}

extension StyleGuide.Font {
	// TODO: add bold, italic, etc.
}

extension StyleGuide {
	enum TextStyle {
		case header
		case subheader
		case sectionHeader
		case sectionSubheader
		case standard
	}
}

extension StyleGuide.TextStyle {
	
	var color: Color {
		switch self {
		case .header:
			return StyleGuide.Color.Text.primary
		case .subheader:
			return StyleGuide.Color.Text.secondary
		case .sectionHeader:
			return StyleGuide.Color.Text.primary
		case .sectionSubheader:
			return StyleGuide.Color.Text.secondary
		case .standard:
			return StyleGuide.Color.Text.primary
		}
	}
	
	var font: Font {
		switch self {
		case .header:
			return Font.title
		case .subheader:
			return Font.title2
		case .sectionHeader:
			return Font.headline
		case .sectionSubheader:
			return Font.subheadline
		case .standard:
			return Font.body
		}
	}
	
}

extension Text {
	func textStyle(_ textStyle: StyleGuide.TextStyle) -> Text {
		return self
			.foregroundColor(textStyle.color)
			.font(textStyle.font)
	}
}
