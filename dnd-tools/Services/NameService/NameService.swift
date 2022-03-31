
import Combine

protocol NameService {
	func getRandomCharacterNames(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never>
}
