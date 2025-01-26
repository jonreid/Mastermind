struct FeedbackPegs {
    private let secret: Secret

    var pegs: [FeedbackPeg] {
        Array(repeating: .empty, count: secret.size)
    }

    init(secret: Secret) {
        self.secret = secret
    }

    var count: Int {
        secret.size
    }
}

enum FeedbackPeg {
    case empty
}
