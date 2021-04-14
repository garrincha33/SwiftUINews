//
//  ResultState.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation
//create an enum for managing the 3 states that our app could possibly be in
enum ResultState {
    case loading ///app is loading using a spinner
    case success(content: [Article]) /// success we can now display available articles
    case failed(error: Error) ///there is an error use this state to represent that
}
