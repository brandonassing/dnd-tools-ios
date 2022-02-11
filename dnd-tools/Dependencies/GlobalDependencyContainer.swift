
typealias AllDependencies = HasNameService & HasNameRepository

class GlobalDependencyContainer: AllDependencies {
	
	static let shared = GlobalDependencyContainer()

	lazy var nameService: NameService = {
		NameAPIService()
	}()
	
	lazy var nameRepository: NameRepository = {
		CharacterNameRepository(dependencies: self)
	}()

}
