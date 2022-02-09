
import Combine

class NameAPIService: NameService {
	
	func getRandomCharacterName(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		return Just(Result<[String], Error>.success([""]))
			.eraseToAnyPublisher()
	}
}
