
import Combine

protocol NameService {
	func getRandomCharacterName(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never>
}
