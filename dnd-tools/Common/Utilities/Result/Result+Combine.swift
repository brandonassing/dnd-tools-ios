
import Combine

extension Publisher where Output: ResultProtocol, Failure == Never {
	func unwrapSuccess() -> AnyPublisher<Output.Success, Never> {
		return self
			.map({ $0.success })
			.compactMap({ $0 })
			.eraseToAnyPublisher()
	}
	
	func unwrapFailure() -> AnyPublisher<Output.Failure, Never> {
		return self
			.map({ $0.failure })
			.compactMap({ $0 })
			.eraseToAnyPublisher()
	}
	
	func mapSuccess<T>(_ transform: @escaping (Output.Success) -> T) -> AnyPublisher<Result<T, Output.Failure>, Never> {
		return self
			.map({ result in
				return result.map({ transform($0) })
			})
			.eraseToAnyPublisher()
	}
}
