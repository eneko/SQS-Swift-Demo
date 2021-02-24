//
//  Producer.swift
//
//
//  Created by Eneko Alonso on 2/23/21.
//

import Foundation
import SotoSQS

let arguments = ProcessInfo.processInfo.arguments
guard arguments.count > 1 else {
    print("Nothing to send")
    exit(0)
}

let client = AWSClient(httpClientProvider: .createNew)
defer { try? client.syncShutdown() }
let sqs = SQS(client: client, region: .uswest2)
let queue = "https://sqs.us-west-2.amazonaws.com/<account>/sqs-swift-demo"

for message in arguments.dropFirst() {
    let input = SQS.SendMessageRequest(messageBody: message, queueUrl: queue)
    let result = try sqs.sendMessage(input).wait()
    print(result.messageId ?? "[No id]")
}
