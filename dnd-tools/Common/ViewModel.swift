//
//  ViewModel.swift
//  dnd-tools
//
//  Created by Brandon Assing on 2022-02-08.
//

import Foundation

protocol ViewModelInputs {
	associatedtype Inputs
	var inputs: Inputs { get }
}

protocol ViewModelOutputs {
	associatedtype Outputs
	var outputs: Outputs { get }
}

typealias ViewModel = ViewModelInputs & ViewModelOutputs
