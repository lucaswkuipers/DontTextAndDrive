func log<Message>(_ message: Message) {
    #if DEBUG
    print(message)
    #endif
}
