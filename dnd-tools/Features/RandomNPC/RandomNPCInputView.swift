
import SwiftUI
import Combine

extension RandomNPC {
	struct InputView: View {
		
		@StateObject private var viewModel = InputViewModel(dependencies: GlobalDependencyContainer.shared)
		@State private var generatedNPC: NPC?
		@State private var selectedRace: Race?
		
		private var disposables = Set<AnyCancellable>()
		
		var body: some View {
			ScrollView {
				VStack(spacing: 0) {
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
