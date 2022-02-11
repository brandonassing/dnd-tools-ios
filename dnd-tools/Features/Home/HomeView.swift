
import SwiftUI

struct HomeView: View {
    var body: some View {
		NavigationView {
			Group {
				VStack {
					Text("D&D Tools")
						.textStyle(.header)
					
					Spacer()
						.frame(height: 10)

					Text("A collection of tools and utilities for Dungeons and Dragons")
						.textStyle(.subheader)
					
					Spacer()
						.frame(height: 50)
					
					Button(action: {}) {
						NavigationLink(destination: RandomNPC.InputView()) {
							Text("Random NPC Generator")
								.foregroundColor(StyleGuide.Color.Text.light)
								.padding()
						}
					}
					.background(StyleGuide.Color.tertiary)
					.cornerRadius(5)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.background(StyleGuide.Color.background)
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
