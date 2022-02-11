
import SwiftUI

extension RandomNPC {
	struct DetailsView: View {
		let npc: NPC
		
		@Environment(\.presentationMode) var presentationMode

		var body: some View {
			NavigationView {
				VStack(alignment: .leading) {
					let characterDescription = "\(self.npc.race.displayName) \(self.npc.ageGroup.displayName.lowercased()) (\(self.npc.gender.displayName.lowercased()))"
					Text(characterDescription)
						.textStyle(.sectionHeader)
					
					Spacer()
						.frame(height: 20)
					
					Text("Proportions")
						.textStyle(.sectionSubheader)
					Text("Height: \(self.npc.heightCm.toFeetAndInches().feet)'\(self.npc.heightCm.toFeetAndInches().inches)\"")
						.textStyle(.standard)
					Text("Body type: \(self.npc.bodyType.name)")
						.textStyle(.standard)
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.navigationTitle(self.npc.name)
				.navigationBarTitleDisplayMode(.large)
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
