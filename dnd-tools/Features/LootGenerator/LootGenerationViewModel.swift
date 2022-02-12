
import Combine

class LootGenerationViewModel: ObservableObject, ViewModel {
	
	typealias Dependencies = HasLootService
	
	struct Inputs {
		
	}
	
	struct Outputs {
		
	}
	
	var inputs: Inputs
	var outputs: Outputs
	
	init() {
		
		self.inputs = Inputs(
		
		)
		
		self.outputs = Outputs(
		
		)
	}
	
}
