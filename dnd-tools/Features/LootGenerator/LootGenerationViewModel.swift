
import Combine
import CombineExt

class LootGenerationViewModel: ObservableObject, ViewModel {
	
	typealias Dependencies = HasLootService
	
	struct Inputs {
		let generate: PassthroughSubject<Void, Never>
	}
	
	struct Outputs {
		let loot: AnyPublisher<String, Never>
	}
	
	var inputs: Inputs
	var outputs: Outputs
	
	init(dependencies: Dependencies) {
		
		let generateSubject = PassthroughSubject<Void, Never>()
		
		self.inputs = Inputs(
			generate: generateSubject
		)
		
		let lootRequest = generateSubject
			.flatMapLatest({ _ in
				dependencies.lootService.getRandomLoot(limit: 1)
			})
		
		let lootSuccess = lootRequest
			.filter({
				switch $0 {
				case .success:
					return true
				case .failure:
					return false
				}
			})
			.map({ result -> String? in
				switch result {
				case .success(let loot):
					return loot.first
				case .failure:
					return nil
				}
			})
			.compactMap({ $0 })
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()

		self.outputs = Outputs(
			loot: lootSuccess
		)
	}
	
}
