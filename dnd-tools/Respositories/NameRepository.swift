
import Combine

protocol NameRepository {
	func getRandomName(for race: Race, _ gender: Gender) -> AnyPublisher<Result<String, Error>, Never>
}

class CharacterNameRepository: NameRepository {
	typealias Dependencies = HasNameService
	
	private func buildCharacterType(for race: Race, _ gender: Gender) -> String {
		if race == .tiefling {
			return race.apiValue
		}
		return "\(race.apiValue)+\(gender.apiValue)"
	}
	
	func getRandomName(for race: Race, _ gender: Gender) -> AnyPublisher<Result<String, Error>, Never> {
		return self.nameService.getRandomCharacterNames(characterType: self.buildCharacterType(for: race, gender), limit: 1)
			.map({ result in
				switch result {
				case .success(let names):
					guard let firstName = names.first else {
						return .failure(GenericError.unknown)
					}
					return .success(firstName)
				case .failure(let error):
					return .failure(error)
				}
			})
			.eraseToAnyPublisher()
	}
	
	private let nameService: NameService
	
	init(dependencies: Dependencies) {
		self.nameService = dependencies.nameService
	}
}

fileprivate extension Race {
	var apiValue: String {
		switch self {
		case .human:
			return "Human"
		case .halfling:
			return "Halfling"
		case .dwarf:
			return "Dwarvish"
		case .elf:
			return "Elvish"
		case .gnome:
			return "German"
		case .dragonborn:
			return "Draconic"
		case .halfElf:
			return ["Elvish", "Human"].randomElement() ?? "Elvish"
		case .halfOrc:
			return ["Orcish", "Human"].randomElement() ?? "Orcish"
		case .tiefling:
			return "Fiendish"
		}
	}
}

fileprivate extension Gender {
	var apiValue: String {
		return self.displayName
	}
}
