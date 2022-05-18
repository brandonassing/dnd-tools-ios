
import Foundation
import Combine

enum GenericError: Error {
	case api(statusCode: Int? = nil)
	case decoding
	case unknown
	case badUrl
}

protocol APIError: Error {
	var statusCode: Int { get set }
	var reason: APIErrorReason { get }
}

protocol APIErrorReason {
	var rawValue: String { get }
}

struct RawAPIErrorReason: APIErrorReason, Decodable {
	let rawValue: String
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.rawValue = try container.decode(String.self)
	}
	
	init(rawValue: String) {
		self.rawValue = rawValue
	}
}

struct BasicAPIError: APIError {
	var statusCode: Int
	let reason: APIErrorReason
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
	
	func parseAPIResponse<ResponseType, ErrorType>(resultType: ResponseType.Type, errorType: ErrorType.Type) -> AnyPublisher<ResponseType, Error> where ResponseType: Decodable, ErrorType: APIError & Decodable {
		// TODO: implement
		return Empty().eraseToAnyPublisher()
	}
}
