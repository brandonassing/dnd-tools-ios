//
//  NPC.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-08.
//

import Foundation

struct NPC: Identifiable {
	let id = UUID()
	let name: String
	let heightCm: Int
	let bodyType: BodyType
	let race: Race
	let ageGroup: AgeGroup
}

enum AgeGroup: String, CaseIterable {
	case infant
	case child
	case youth
	case adult
	case senior
}

extension AgeGroup {
	var name: String {
		return self.rawValue.capitalizingFirstLetter()
	}
}

enum BodyType: String, CaseIterable {
	case underweight
	case slender
	case average
	case athletic
	case bulky
	case overweight
}

extension BodyType {
	var name: String {
		return self.rawValue
	}
}

enum Race: String, CaseIterable {
	case human
	case halfling
	case dwarf
	case elf
	case gnome
	case dragonborn
	case halfElf
	case halfOrc
	case tiefling
}

extension Race {
	var isCommon: Bool {
		switch self {
		case .human, .halfling, .dwarf, .elf, .halfElf:
			return true
		case .gnome, .dragonborn, .halfOrc, .tiefling:
			return false
		}
	}
	
	var name: String {
		switch self {
		case .human, .halfling, .dwarf, .elf, .gnome, .dragonborn, .tiefling:
			return self.rawValue.capitalizingFirstLetter()
		case .halfElf:
			return "Half-Elf"
		case .halfOrc:
			return "Half-Orc"
		}
	}
	
	var lifespan: Int {
		switch self {
		case .human:
			return 100
		case .halfling:
			return 150
		case .dwarf:
			return 350
		case .elf:
			return 750
		case .gnome:
			return 500
		case .dragonborn:
			return 80
		case .halfElf:
			return 200
		case .halfOrc:
			return 75
		case .tiefling:
			return 120
		}
	}
	
	var adultHeightRange: ClosedRange<Int> {
		switch self {
		case .human, .halfElf, .tiefling:
			return 150...200
		case .halfling:
			return 90...100
		case .dwarf:
			return 120...160
		case .elf:
			return 150...200
		case .gnome:
			return 90...120
		case .dragonborn:
			return 180...230
		case .halfOrc:
			return 170...210
		}
	}
	
}
