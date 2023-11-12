//
//  AllDessertsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import Foundation
import Combine

class AllDessertsViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    @Published var loadingBuffer: Bool = true
    
    init() {
        subscribeDataService()
        
    }
    
    let dataService = DessertsDataService()
    var cancellables = Set<AnyCancellable>()
    
    func subscribeDataService() {
        dataService.$desserts
            .sink { [weak self] desserts in
                self?.desserts = desserts
                self?.sortDesserts()
                self?.allowLoadingBuffer()
            }
            .store(in: &cancellables)
        
        dataService.$errorMessage
            .sink { [weak self] message in
                if message != "" && message != nil {
                    self?.showAlert = true
                    self?.errorMessage = message
                }
            }
            .store(in: &cancellables)
    }
    
    /// This function sorts the array in alphabetical order. The API Currently delivers the array in alphabetical order but if that should change the UX is preserved via this function.
    func sortDesserts() {
        let sortedDesserts = desserts.sorted(by: {$0.meal < $1.meal })
        desserts = sortedDesserts
    }
    
    func allowLoadingBuffer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5)  {
            self.loadingBuffer = false
        }
    }
}