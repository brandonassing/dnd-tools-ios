
import SwiftUI

extension RandomNPC {
	struct DetailsView: View {
		let npc: NPC

		var body: some View {
			VStack {
				Text(self.npc.name)
					.padding()
				Text(self.npc.race.name)
				Text(self.npc.gender.name)
				Text(self.npc.ageGroup.name)
				Text("Height: \(self.npc.heightCm.toFeetAndInches().feet)'\(self.npc.heightCm.toFeetAndInches().inches)\"")
				Text("Body type: \(self.npc.bodyType.name)")
			}
		}
	}

	struct RandomNPCDetailsView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.DetailsView(npc: NPC(name: "Bob", heightCm: 180, bodyType: .average, race: .human, ageGroup: .adult, gender: .male))
		}
	}
}
