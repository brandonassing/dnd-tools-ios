
import SwiftUI
import Combine

extension RandomNPC {
	struct InputView: View {
		
		@StateObject private var viewModel = InputViewModel(dependencies: GlobalDependencyContainer.shared)
		@State private var generatedNPC: NPC?
		
		private var disposables = Set<AnyCancellable>()
		
		var body: some View {
			ScrollView {
				VStack {
					Button(action: viewModel.inputs.generate.send) {
						Text("Generate")
							.padding()
							.buttonStyle(.bordered)
					}
					.onReceive(self.viewModel.outputs.npc, perform: { npc in
						if let npc = npc {
							self.generatedNPC = npc
						}
					})
					.sheet(item: self.$generatedNPC) { npc in
						RandomNPC.DetailsView(npc: npc)
					}
				}
			}
		}
	}

	struct RandomNPCInputView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.InputView()
		}
	}
}
