
import SwiftUI

struct LootGenerationView: View {
	
	@StateObject private var viewModel = LootGenerationViewModel(dependencies: GlobalDependencyContainer.shared)
	@State private var loot: String?
	
	var body: some View {
		
		VStack(spacing: 0) {
			
			if let loot = self.loot {
				Text(loot)
					.textStyle(.standard)
			}

			Spacer()
			
			PrimaryButtonView(text: "Generate", action: { self.viewModel.inputs.generate.send() })
				.onReceive(self.viewModel.outputs.loot) { loot in
					self.loot = loot
				}
		}
		.padding()
		.navigationTitle("Loot Generator")
		.background(StyleGuide.Color.background)
		
    }
}

struct LootGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        LootGenerationView()
    }
}
