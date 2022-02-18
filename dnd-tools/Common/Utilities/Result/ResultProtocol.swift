
public protocol ResultProtocol {
	associatedtype Success
	associatedtype Failure: Error
	
	init(success: Success)
	init(failure: Failure)
	
	var success: Success? { get }
	var failure: Failure? { get }

	// Taken from Swift.Result
	func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> Result<NewSuccess, Failure>
	func mapError<NewFailure>(_ transform: (Failure) -> NewFailure) -> Result<Success, NewFailure> where NewFailure: Error
	func flatMap<NewSuccess>(_ transform: (Success) -> Result<NewSuccess, Failure>) -> Result<NewSuccess, Failure>
	func flatMapError<NewFailure>(_ transform: (Failure) -> Result<Success, NewFailure>) -> Result<Success, NewFailure> where NewFailure: Error
	func get() throws -> Success
}

extension Result: ResultProtocol {
	public init(success: Success) {
		self = Result.success(success)
	}
	public init(failure: Failure) {
		self = Result.failure(failure)
	}
	
	public var success: Success? {
		guard case .success(let success) = self else {
			return nil
		}
		return success
	}
	public var failure: Failure? {
		guard case .failure(let error) = self else {
			return nil
		}
		return error
	}
}
