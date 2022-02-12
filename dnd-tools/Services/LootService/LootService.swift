
import Combine

protocol LootService {
	
	func getRandomLoot(limit: Int) -> AnyPublisher<Result<[String], Error>, Never>
	
}
