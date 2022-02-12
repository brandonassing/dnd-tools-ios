
import SwiftUI

struct HomeView: View {
	
	@StateObject private var viewModel = HomeViewModel()
	
    var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					Spacer()
						.frame(height: 10)

					Text("A collection of tools and utilities for Dungeons & Dragons 5e")
						.textStyle(.subheader)

					Spacer()
						.frame(height: 50)

					ForEach(self.viewModel.menuItems, id: \.rawValue) { item in
						Button(action: {}) {
							NavigationLink(destination: item.route) {
								Text(item.displayName)
									.foregroundColor(StyleGuide.Color.Text.light)
									.padding()
							}
						}
						.frame(maxWidth: .infinity)
						.background(StyleGuide.Color.tertiary)
						.cornerRadius(5)
					}
					.padding(.leading)
					.padding(.trailing)

				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(StyleGuide.Color.background)
			.navigationTitle("D&D Tools")
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeViewModel.MenuItem {
	
	var route: some View {
		switch self {
		case .npcGenerator:
			return RandomNPC.InputView()
		}
	}
	
}
