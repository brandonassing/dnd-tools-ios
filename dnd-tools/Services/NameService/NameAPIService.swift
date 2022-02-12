
import Foundation
import Combine

class NameAPIService: NameService {
	
	private let session = URLSession.shared
	private let baseUrl = "https://donjon.bin.sh/name/rpc-name.fcgi"
		
	func getRandomCharacterName(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		
		guard let url = URL(string: self.baseUrl + "?type=\(characterType)&n=\(limit)&as_json=1") else {
			return Just(Result.failure(GenericError.apiError))
				.eraseToAnyPublisher()
		}
		
		return self.session.dataTaskPublisher(for: URLRequest(url: url))
			.tryMap({ data, response in
				if let response = response as? HTTPURLResponse,
				   !(200...299).contains(response.statusCode) {
					throw GenericError.apiError
				}
				return data
			})
			.decode(type: [String].self, decoder: JSONDecoder())
			.map({ names in
				return Result.success(names)
			})
			.replaceError(with: .failure(GenericError.apiError))
			.eraseToAnyPublisher()
	}
}
