
import SwiftUI

extension RandomNPC {
	struct DetailsView: View {
		@StateObject private var viewModel: RandomNPC.DetailsViewModel
		
		@Environment(\.presentationMode) var presentationMode

		init(npc: NPC) {
			self._viewModel = StateObject(wrappedValue: RandomNPC.DetailsViewModel(npc: npc, dependencies: GlobalDependencyContainer.shared))
		}
		
		var body: some View {
			NavigationView {
				VStack {
					VStack(alignment: .leading) {
						let characterDescription = "\(self.viewModel.npc.race.displayName) \(self.viewModel.npc.ageGroup.displayName.lowercased()) (\(self.viewModel.npc.gender.displayName.lowercased()))"
						Text(characterDescription)
							.textStyle(.sectionHeader)
						
						Spacer()
							.frame(height: 20)
						
						Text("Proportions")
							.textStyle(.sectionSubheader)
						Text("Height: \(self.viewModel.npc.heightCm.toFeetAndInches().feet)'\(self.viewModel.npc.heightCm.toFeetAndInches().inches)\"")
							.textStyle(.standard)
						Text("Body type: \(self.viewModel.npc.bodyType.displayName)")
							.textStyle(.standard)
						
					}
					.frame(maxWidth: .infinity, alignment: .topLeading)

					Spacer()
					
					PrimaryButtonView(text: "Get new name", action: viewModel.inputs.generateName.send)
				}
				.padding()
				.navigationTitle(self.viewModel.npc.name)
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
							Image(systemName: "xmark")
								.foregroundColor(.secondary)
						}
					}
				}

			}
		}
	}

	struct RandomNPCDetailsView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.DetailsView(npc: NPC(name: "Bob", heightCm: 180, bodyType: .average, race: .human, ageGroup: .adult, gender: .male))
		}
	}
}
