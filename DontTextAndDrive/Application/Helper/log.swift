func log<Message>(_ message: Message) {
    #if DEBUG
    if DebugConfig.showLog {
        print(message)
    }
    #endif
}
