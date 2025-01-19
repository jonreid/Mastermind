struct FeedbackPegs {
    private let secret: Secret

    init(secret: Secret) {
        self.secret = secret
    }

    var count: Int {
        secret.size
    }
}
