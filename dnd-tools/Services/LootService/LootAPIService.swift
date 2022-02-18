
import Foundation
import Combine

class LootAPIService: LootService {
	
	private let session = URLSession.shared
	private let baseUrl = "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi"
	
	func getRandomLoot(limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		guard let url = URL(string: self.baseUrl + "?type=Purse&n=\(limit)") else {
			return Just(Result.failure(GenericError.apiError))
				.eraseToAnyPublisher()
		}
		
		return self.session.dataTaskPublisher(for: url)
			.tryMap({ data, response in
				if let response = response as? HTTPURLResponse,
				   !(200...299).contains(response.statusCode) {
					throw GenericError.apiError
				}
				return data
			})
			.decode(type: [String].self, decoder: JSONDecoder())
			.mapToResult()
			.eraseToAnyPublisher()
	}
	
}
