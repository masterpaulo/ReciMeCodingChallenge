//
//  BaseViewModel.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case error
    }
 
    @Published var loadingState: LoadingState = .idle
    
    lazy var requestLoader: RequestLoader = RequestLoader()
}
