
typealias AllDependencies = HasNameService & HasNameRepository & HasLootService

class GlobalDependencyContainer: AllDependencies {
	
	static let shared = GlobalDependencyContainer()

	lazy var nameService: NameService = {
		NameAPIService()
	}()
	
	lazy var nameRepository: NameRepository = {
		CharacterNameRepository(dependencies: self)
	}()

	lazy var lootService: LootService = {
		LootAPIService()
	}()
}
