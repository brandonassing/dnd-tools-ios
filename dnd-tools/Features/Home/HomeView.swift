//
//  ContentView.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-08.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		NavigationView {
			VStack {
				Text("DnD Tools")
					.padding()
				
				NavigationLink(destination: RandomNPC.InputView()) {
					Text("Random NPC Generator")
				}
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
