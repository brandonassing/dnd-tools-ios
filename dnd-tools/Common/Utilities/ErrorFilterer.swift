
// Usage example:
// let errorFilterer = ErrorFilterer()
// let notFoundError = apiError
//   .filter(errorFilterer.filterFor(statusCode: 400, reason: LootAPIErrorReason.notFound))
// let otherErrors = apiError
//   .filter(errorFilterer.filterForOtherErrors())

class ErrorFilterer {
	typealias ErrorFilter = (Error) -> (Bool)
	
	private struct Criteria: Hashable {
		let statusCode: Int?
		let reason: APIErrorReason?
		
		static func == (lhs: ErrorFilterer.Criteria, rhs: ErrorFilterer.Criteria) -> Bool {
			return lhs.statusCode == rhs.statusCode && lhs.reason?.rawValue == rhs.reason?.rawValue
		}
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(self.statusCode)
			hasher.combine(self.reason?.rawValue)
		}
	}
	
	private var matchedCriteria = Set<Criteria>()
	
	private func filterFor(statusCode: Int? = nil, reason: APIErrorReason? = nil) -> ErrorFilter {
		self.matchedCriteria.insert(Criteria(statusCode: statusCode, reason: reason))
		let filter = { (error: Error) -> Bool in
			return error.isAPIError(statusCode: statusCode, reason: reason)
		}
		return filter
	}
	
	func filterFor(statusCode: Int) -> ErrorFilter {
		return self.filterFor(statusCode: statusCode as Int?)
	}
	
	func filterFor(reason: APIErrorReason) -> ErrorFilter {
		return self.filterFor(reason: reason as APIErrorReason?)
	}
	
	func filterFor(statusCode: Int, reason: APIErrorReason) -> ErrorFilter {
		return self.filterFor(statusCode: statusCode as Int?, reason: reason as APIErrorReason?)
	}
	
	func filterForOtherErrors() -> ErrorFilter {
		let allCriteria = self.matchedCriteria
		let filter = { (error: Error) -> Bool in
			for criteria in allCriteria {
				if error.isAPIError(statusCode: criteria.statusCode, reason: criteria.reason) {
					return false
				}
			}
			return true
		}
		return filter
	}
}
