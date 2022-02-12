
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
	
	@Published var menuItems = MenuItem.allCases
	
}

extension HomeViewModel {
	enum MenuItem: Int, CaseIterable {
		case npcGenerator
		case lootGenerator
		
		var displayName: String {
			switch self {
			case .npcGenerator:
				return "NPC Generator"
			case .lootGenerator:
				return "Loot Generator"
			}
		}
	}
}
