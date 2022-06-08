
import Combine
import SwiftUI

extension RandomNPC {
	class DetailsViewModel: ObservableObject, ViewModelInputs {
		typealias Dependencies = HasNameRepository
		
		struct Inputs {
			let generateName: PassthroughSubject<Void, Never>
		}
				
		@Published var npc: NPC

		var inputs: Inputs
		
		private var disposables = Set<AnyCancellable>()
		
		init(npc: NPC, dependencies: Dependencies) {
			self.npc = npc
			
			let generateNameSubject = PassthroughSubject<Void, Never>()
			self.inputs = Inputs(
				generateName: generateNameSubject
			)
			
			generateNameSubject
				.map({ dependencies.nameRepository.getRandomName(for: npc.race, npc.gender) })
				.switchToLatest()
				.unwrapSuccess()
				.map({ NPC(name: $0, heightCm: npc.heightCm, bodyType: npc.bodyType, race: npc.race, ageGroup: npc.ageGroup, gender: npc.gender) })
				.receive(on: DispatchQueue.main)
				.assign(to: &self.$npc)
		}
	}
}
