
import SwiftUI

struct LootGenerationView: View {
	
	@StateObject private var viewModel = LootGenerationViewModel(dependencies: GlobalDependencyContainer.shared)
	
	var body: some View {
		
		VStack(spacing: 0) {
			
			if let loot = self.viewModel.loot {
				Text(loot)
					.textStyle(.standard)
			}

			Spacer()
			
			PrimaryButtonView(text: "Generate", action: { self.viewModel.inputs.generate.send() })
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
