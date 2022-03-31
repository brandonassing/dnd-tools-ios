
import Foundation
import Combine

enum GenericError: Error {
	case api(statusCode: Int? = nil)
	case decoding
	case unknown
	case badUrl
}

extension URLSession.DataTaskPublisher {
	func parseAPIResponse<ResponseType: Decodable>(resultType: ResponseType.Type) -> AnyPublisher<ResponseType, Error> {
		return self
			.tryMap({ data, response in
				guard let response = response as? HTTPURLResponse else {
					throw GenericError.unknown
				}
				if !(200...299).contains(response.statusCode) {
					throw GenericError.api(statusCode: response.statusCode)
				}
				return data
			})
			.decode(type: ResponseType.self, decoder: JSONDecoder())
			.mapError({ error -> GenericError in
				if error is DecodingError {
					return .decoding
				}
				guard let error = error as? GenericError else {
					return .unknown
				}
				return error
			})
			.eraseToAnyPublisher()
	}
}
