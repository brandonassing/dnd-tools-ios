
import Foundation
import Combine

class LootAPIService: LootService {
	
	private let session = URLSession.shared
	private let baseUrl = "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi"
	
	func getRandomLoot(limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		guard let url = URL(string: self.baseUrl + "?type=Purse&n=\(limit)") else {
			return Just(Result.failure(GenericError.badUrl))
				.eraseToAnyPublisher()
		}
		
		return self.session.dataTaskPublisher(for: url)
			.parseAPIResponse(resultType: [String].self)
			.mapToResult()
	}
	
}
