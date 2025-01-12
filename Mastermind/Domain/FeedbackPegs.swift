struct FeedbackPegs {
    let secret: Secret

    var count: Int {
        secret.secretSize
    }
}
