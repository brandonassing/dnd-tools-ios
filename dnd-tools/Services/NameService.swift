//
//  NameService.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-09.
//

import Combine

protocol NameService {
	func getRandomCharacterName(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never>
}
