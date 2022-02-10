
import SwiftUI
import Combine

extension RandomNPC {
	struct InputView: View {
		
		@StateObject private var viewModel = InputViewModel(dependencies: GlobalDependencyContainer.shared)
		@State private var generatedNPC: NPC?
		@State private var selectedRace: Race?
		@State private var selectedAge: AgeGroup?
		@State private var selectedGender: Gender?

		private var disposables = Set<AnyCancellable>()
		
		var body: some View {
			ScrollView {
				VStack(spacing: 0) {
					
					// TODO: Can maybe turn into generic component using Generics and a ForEach?
					Text("Race")
						.textStyle(.sectionHeader)
					let anyRaceText = "Any race"
					Menu(self.selectedRace?.name ?? anyRaceText) {
						Button(anyRaceText, action: { self.viewModel.inputs.selectedRace.send(nil) })
						
						ForEach(self.viewModel.races, id: \.rawValue) { race in
							Button(race.name, action: { self.viewModel.inputs.selectedRace.send(race) })
						}
					}
					.onReceive(self.viewModel.outputs.selectedRace, perform: { race in
						self.selectedRace = race
					})
					
					Spacer(minLength: 20)

					Text("Age")
						.textStyle(.sectionHeader)
					let anyAgeText = "Any age"
					Menu(self.selectedAge?.name ?? anyAgeText) {
						Button(anyAgeText, action: { self.viewModel.inputs.selectedAge.send(nil) })
						
						ForEach(self.viewModel.ageGroups, id: \.rawValue) { age in
							Button(age.name, action: { self.viewModel.inputs.selectedAge.send(age) })
						}
					}
					.onReceive(self.viewModel.outputs.selectedAge, perform: { age in
						self.selectedAge = age
					})
					
					Spacer(minLength: 20)

					Text("Gender")
						.textStyle(.sectionHeader)
					let anyGenderText = "Any gender"
					Menu(self.selectedGender?.name ?? anyGenderText) {
						Button(anyGenderText, action: { self.viewModel.inputs.selectedGender.send(nil) })
						
						ForEach(self.viewModel.genders, id: \.rawValue) { gender in
							Button(gender.name, action: { self.viewModel.inputs.selectedGender.send(gender) })
						}
					}
					.onReceive(self.viewModel.outputs.selectedGender, perform: { gender in
						self.selectedGender = gender
					})
					
					Spacer(minLength: 20)

					PrimaryButtonView(text: "Generate", action: viewModel.inputs.generate.send)
					.onReceive(self.viewModel.outputs.npc, perform: { npc in
						if let npc = npc {
							self.generatedNPC = npc
						}
					})
					.sheet(item: self.$generatedNPC) { npc in
						RandomNPC.DetailsView(npc: npc)
					}
				}
				.padding()
			}
			.frame(maxWidth: .infinity)
			.background(StyleGuide.Color.background)
		}
	}

	struct RandomNPCInputView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.InputView()
		}
	}
}
