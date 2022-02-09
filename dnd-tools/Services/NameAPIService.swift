//
//  NameAPIService.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-09.
//

import Combine

class NameAPIService: NameService {
	
	func getRandomCharacterName(characterType: String, limit: Int) -> AnyPublisher<Result<[String], Error>, Never> {
		return Just(Result<[String], Error>.success([""]))
			.eraseToAnyPublisher()
	}
}
