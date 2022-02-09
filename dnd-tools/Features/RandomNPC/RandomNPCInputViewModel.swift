//
//  RandomNPCInputViewModel.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-08.
//

import Foundation
import Combine
import SwiftUI

extension RandomNPC {
	class InputViewModel: ObservableObject, ViewModel {
		struct Inputs {
			let generate: PassthroughSubject<Void, Never>
		}
		
		struct Outputs {
			let npc: AnyPublisher<NPC?, Never>
		}
		
		var inputs: Inputs
		var outputs: Outputs
		
		init() {
			let generateSubject = PassthroughSubject<Void, Never>()
			self.inputs = Inputs(
				generate: generateSubject
			)
			
			let npc = generateSubject
				.map({ _ -> NPC? in
					let race = Race.allCases.randomElement() ?? .human
					let ageGroup = AgeGroup.allCases.randomElement() ?? .adult
					let bodyType = BodyType.allCases.randomElement() ?? .average
					guard let randomHeight = race.heightRange.randomElement() else {
						return nil
					}
					return NPC(name: "Bob Vance", heightCm: Int(randomHeight), bodyType: bodyType, race: race, ageGroup: ageGroup)
				})
				.receive(on: DispatchQueue.main)
				.eraseToAnyPublisher()
			
			self.outputs = Outputs(
				npc: npc
			)
		}
	}
}