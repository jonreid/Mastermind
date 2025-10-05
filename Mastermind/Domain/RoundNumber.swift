struct RoundNumber {
    let value: Int

    init(value: Int) {
        assert(1 <= value)
        assert(value <= 10)
        self.value = value
    }

    var index: Int {
        value - 1
    }
}
