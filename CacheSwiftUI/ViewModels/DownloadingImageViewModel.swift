//
//  DownloadingImageViewModel.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import Foundation
import Combine

class DownloadingImageViewModel: ObservableObject {
    
    @Published var datas: [PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()
    let dataService = DataService.shared
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        dataService.$photos
            .sink {[weak self] model in
                self?.datas = model
            }
            .store(in: &cancellables)
            
    }
}
