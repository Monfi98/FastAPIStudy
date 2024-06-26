//
//  NetworkManager.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/16/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let monitors = [MyMonitor()] as [EventMonitor]
    
    var session: Session
    
    private init() {
        session = Session(eventMonitors: monitors)
    }
}
