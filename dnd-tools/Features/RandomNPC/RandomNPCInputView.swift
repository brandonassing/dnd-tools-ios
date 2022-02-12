
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
			
			VStack(spacing: 0) {
				ScrollView {
					VStack(spacing: 0) {
						DropdownView<Race>(
							labelText: "Race",
							noSelectionText: "Any race",
							noSelectionAction: { self.viewModel.inputs.selectedRace.send(nil) },
							items: self.viewModel.races,
							selectAction: { selected in self.viewModel.inputs.selectedRace.send(selected) },
							selectPublisher: self.viewModel.outputs.selectedRace
						)

						Divider()
						
						DropdownView<AgeGroup>(
							labelText: "Age",
							noSelectionText: "Any age",
							noSelectionAction: { self.viewModel.inputs.selectedAge.send(nil) },
							items: self.viewModel.ageGroups,
							selectAction: { selected in self.viewModel.inputs.selectedAge.send(selected) },
							selectPublisher: self.viewModel.outputs.selectedAge
						)

						Divider()
						
						DropdownView<Gender>(
							labelText: "Gender",
							noSelectionText: "Any gender",
							noSelectionAction: { self.viewModel.inputs.selectedGender.send(nil) },
							items: self.viewModel.genders,
							selectAction: { selected in self.viewModel.inputs.selectedGender.send(selected) },
							selectPublisher: self.viewModel.outputs.selectedGender
						)

					}
					.cornerRadius(8)
					.padding()

				}
				
				PrimaryButtonView(text: "Generate", action: viewModel.inputs.generate.send)
					.onReceive(self.viewModel.outputs.npc, perform: { npc in
						if let npc = npc {
							self.generatedNPC = npc
						}
					})
					.sheet(item: self.$generatedNPC) { npc in
						RandomNPC.DetailsView(npc: npc)
					}
					.padding()
			}
			.background(StyleGuide.Color.background)
			.navigationTitle("NPC Generator")
		}
	}

	struct RandomNPCInputView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.InputView()
		}
	}
}
