
import SwiftUI

struct PrimaryButtonView: View {
	var text: String?
	var action: (() -> Void)
	
    var body: some View {
		Button(action: self.action) {
			if let text = self.text {
				Text(text)
					.foregroundColor(StyleGuide.Color.Text.light)
					.padding()
					.frame(maxWidth: .infinity)
			}
		}
		.background(StyleGuide.Color.secondary)
		.cornerRadius(8)
	}
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
		PrimaryButtonView(text: "Primary button", action: { print("Button tapped") })
    }
}
