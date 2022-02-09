
import SwiftUI
import Combine

extension RandomNPC {
	struct InputView: View {
		
		@ObservedObject private var viewmodel = InputViewModel(dependencies: GlobalDependencyContainer.shared)
		@State private var generatedNPC: NPC?
		
		private var disposables = Set<AnyCancellable>()

		init() {
			self.setup()
		}
		
		var body: some View {
			ScrollView {
				VStack {
					Button(action: viewmodel.inputs.generate.send) {
						Text("Generate")
							.padding()
							.buttonStyle(.bordered)
					}
					.onReceive(self.viewmodel.outputs.npc, perform: { npc in
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
		
		private mutating func setup() {
			self.viewmodel.outputs.npc
				.sink(receiveValue: { npc in

				})
				.store(in: &self.disposables)
		}
	}

	struct RandomNPCInputView_Previews: PreviewProvider {
		static var previews: some View {
			RandomNPC.InputView()
		}
	}
}
