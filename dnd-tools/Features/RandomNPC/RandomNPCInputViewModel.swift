
import Combine
import SwiftUI

extension RandomNPC {
	class InputViewModel: ObservableObject, ViewModel {
		typealias Dependencies = HasNameRepository
		typealias NPCInfo = (heightCm: Int, bodyType: BodyType, race: Race, ageGroup: AgeGroup, gender: Gender)
		
		struct Inputs {
			let selectedRace: CurrentValueSubject<Race?, Never>
			let selectedAge: CurrentValueSubject<AgeGroup?, Never>
			let selectedGender: CurrentValueSubject<Gender?, Never>
			let generate: PassthroughSubject<Void, Never>
		}
		
		struct Outputs {
			let selectedRace: AnyPublisher<Race?, Never>
			let selectedAge: AnyPublisher<AgeGroup?, Never>
			let selectedGender: AnyPublisher<Gender?, Never>
			let npc: AnyPublisher<NPC?, Never>
		}
		
		// TODO: not sure if this is the best way to output races
		@Published var races = Race.allCases
		@Published var ageGroups = AgeGroup.allCases
		@Published var genders = Gender.allCases

		var inputs: Inputs
		var outputs: Outputs
		
		init(dependencies: Dependencies) {
			// TODO: not sure how to use this with `withLatestFrom`
			let selectedRaceSubject = CurrentValueSubject<Race?, Never>(Race?.none)
			let selectedAgeSubject = CurrentValueSubject<AgeGroup?, Never>(AgeGroup?.none)
			let selectedGenderSubject = CurrentValueSubject<Gender?, Never>(Gender?.none)
			let generateSubject = PassthroughSubject<Void, Never>()
			self.inputs = Inputs(
				selectedRace: selectedRaceSubject,
				selectedAge: selectedAgeSubject,
				selectedGender: selectedGenderSubject,
				generate: generateSubject
			)
			
			let selectedRace = selectedRaceSubject
				.eraseToAnyPublisher()
			let selectedAge = selectedAgeSubject
				.eraseToAnyPublisher()
			let selectedGender = selectedGenderSubject
				.eraseToAnyPublisher()

			let npcInfo = generateSubject
				.map({ _ -> NPCInfo? in
					let race = Race.allCases.randomElement() ?? .human
					let ageGroup = AgeGroup.allCases.randomElement() ?? .adult
					let bodyType = BodyType.allCases.randomElement() ?? .average
					let gender = Gender.allCases.randomElement() ?? .male
					guard let randomHeight = race.adultHeightRange.randomElement() else {
						return nil
					}
					var height = Double(randomHeight)
					if ageGroup == .child {
						height = height * 0.75
					}
					return (heightCm: Int(height), bodyType: bodyType, race: race, ageGroup: ageGroup, gender: gender)
				})
				.share()
			
			let npcNameRequest = npcInfo
				.map({ npcInfo -> AnyPublisher<Result<String, Error>, Never> in
					guard let npcInfo = npcInfo else {
						return Empty<Result<String, Error>, Never>()
							.eraseToAnyPublisher()
					}
					return dependencies.nameRepository.getRandomName(for: npcInfo.race, npcInfo.gender)
				})
				.switchToLatest()
			
			// TODO: handle success/failure parsing better
			let npcNameSuccess = npcNameRequest
				.filter({
					switch $0 {
					case .success:
						return true
					case .failure:
						return false
					}
				})
				.map({ result -> String? in
					switch result {
					case .success(let name):
						return name
					case .failure:
						return nil
					}
				})
			
			let npc = Publishers.Zip(npcInfo, npcNameSuccess)
				.map({ (npcInfo, name) -> NPC? in
					guard let npcInfo = npcInfo, let name = name else {
						return nil
					}
					return NPC(name: name, heightCm: npcInfo.heightCm, bodyType: npcInfo.bodyType, race: npcInfo.race, ageGroup: npcInfo.ageGroup, gender: npcInfo.gender)
				})
				.receive(on: DispatchQueue.main)
				.eraseToAnyPublisher()

			self.outputs = Outputs(
				selectedRace: selectedRace,
				selectedAge: selectedAge,
				selectedGender: selectedGender,
				npc: npc
			)
		}
	}
}
