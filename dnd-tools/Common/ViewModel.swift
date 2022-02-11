
protocol ViewModelInputs {
	associatedtype Inputs
	var inputs: Inputs { get }
}

protocol ViewModelOutputs {
	associatedtype Outputs
	var outputs: Outputs { get }
}

typealias ViewModel = ViewModelInputs & ViewModelOutputs
