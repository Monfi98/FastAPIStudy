//
//  MyMonitor.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import Foundation
import Alamofire

final class MyMonitor: EventMonitor {
    let queue = DispatchQueue(label: "EventMonitor")
    
    // Event called when any type of Request is resumed.
    func requestDidResume(_ request: Request) {
        print("EventMonitor - Resuming: \(request)")
    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("EventMonitor - Finished: \(response)")
    }
}
