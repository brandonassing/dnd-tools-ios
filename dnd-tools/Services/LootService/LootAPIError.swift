
import Foundation

// TODO: this doesn't match API error spec
// Example response
// {
//	 status: 400,
//	 reasonCode: "NOT_FOUND"
// }

struct LootAPIError: APIError, Decodable {
	var statusCode: Int
	let reason: APIErrorReason
	
	private enum CodingKeys: String, CodingKey {
		case status
		case reasonCode
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.statusCode = try container.decode(Int.self, forKey: .status)
		self.reason = try container.decode(RawAPIErrorReason.self, forKey: .reasonCode)
	}
}
