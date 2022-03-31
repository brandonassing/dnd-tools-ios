
import Combine
import CombineExt

class LootGenerationViewModel: ObservableObject {
	
	typealias Dependencies = HasLootService
	
	// MARK: Inputs
	struct Inputs {
		let generate: PassthroughSubject<Void, Never>
	}
	
	// MARK: Outputs
	@Published var loot: String?

	var inputs: Inputs
	
	init(dependencies: Dependencies) {
		
		let generateSubject = PassthroughSubject<Void, Never>()
		
		self.inputs = Inputs(
			generate: generateSubject
		)
		
		let lootRequest = generateSubject
			.flatMapLatest({ _ in
				dependencies.lootService.getRandomLoot(limit: 1)
			})
		
		lootRequest
			.unwrapSuccess()
			.map({ $0.first })
			.receive(on: DispatchQueue.main)
			.assign(to: &self.$loot)
		
	}
	
}
