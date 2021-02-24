//
//  Consumer.swift
//  
//
//  Created by Eneko Alonso on 2/23/21.
//

import Foundation
import SotoSQS

let client = AWSClient(httpClientProvider: .createNew)
defer { try? client.syncShutdown() }
let sqs = SQS(client: client, region: .uswest2)
let queue = "https://sqs.us-west-2.amazonaws.com/<account>/sqs-swift-demo"

// Poll for messages, waiting for up to 10 seconds
let request = SQS.ReceiveMessageRequest(queueUrl: queue, waitTimeSeconds: 10)

// Fetch messages forever, until interrupted or terminated
while true {
    print("Polling for messages...")
    let result = try sqs.receiveMessage(request).wait()
    for message in result.messages ?? [] {
        print("Message Id:", message.messageId ?? "[no id]")
        print("Content:", message.body ?? "[no message]")

        if let handle = message.receiptHandle {
            let deleteRequest = SQS.DeleteMessageRequest(queueUrl: queue, receiptHandle: handle)
            _ = try sqs.deleteMessage(deleteRequest).wait()
        }
    }
}
