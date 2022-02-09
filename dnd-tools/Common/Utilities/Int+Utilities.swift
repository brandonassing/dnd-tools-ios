
extension Int {
	// Converts cm to feet and inches
	func toFeetAndInches() -> (feet: Int, inches: Int) {
		let inches = Double(self) * 0.39
		return (feet: Int(inches / 12), inches: Int(inches.truncatingRemainder(dividingBy: 12)))
	}
}
