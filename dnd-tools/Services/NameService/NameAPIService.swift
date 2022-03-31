
import Foundation
import Combine

class NameAPIService: NameService {
	
	private let session = URLSession.shared
	private let baseUrl = "https://donjon.bin.sh/name/rpc-name.fcgi"
		
	func getRandomCharacterNames(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		
		guard let url = URL(string: self.baseUrl + "?type=\(characterType)&n=\(limit)&as_json=1") else {
			return Just(Result.failure(GenericError.badUrl))
				.eraseToAnyPublisher()
		}
		
		return self.session.dataTaskPublisher(for: URLRequest(url: url))
			.parseAPIResponse(resultType: [String].self)
			.mapToResult()
	}
}
