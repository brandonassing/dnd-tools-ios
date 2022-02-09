//
//  String+Utilities.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-08.
//

import Foundation

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + self.lowercased().dropFirst()
	}
}
