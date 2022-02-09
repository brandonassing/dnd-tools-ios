
import Combine

protocol NameRepository {
	func getRandomName(for race: Race, _ gender: Gender) -> AnyPublisher<Result<String, Error>, Never>
}

class CharacterNameRepository: NameRepository {
	typealias Dependencies = HasNameService
	
	func getRandomName(for race: Race, _ gender: Gender) -> AnyPublisher<Result<String, Error>, Never> {
		return self.nameService.getRandomCharacterName(characterType: "Human+Male", limit: 1)
			.map({ result in
				if case .success(let names) = result, let name = names.first {
					return .success(name)
				}
				return .failure(GenericError.apiError)
			})
			.eraseToAnyPublisher()
	}
	
	private let nameService: NameService
	
	init(dependencies: Dependencies) {
		self.nameService = dependencies.nameService
	}
}
