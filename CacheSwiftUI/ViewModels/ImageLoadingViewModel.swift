//
//  ImageLoadingViewModel.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var manager = CacheManager.shared
    
    let urlString: String
    let imageKey: String
    var cancellable = Set<AnyCancellable>()
    
    init(urlString: String, key: String) {
        self.urlString = urlString
        self.imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(to: imageKey) {
            image = savedImage
            print("getting cache")
        } else {
            downloadImage()
            print("downloaded image")
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: {[weak self] image in
                guard let strongSelf = self, let image = image else {return}
                strongSelf.image = image
                strongSelf.manager.add(with: strongSelf.imageKey, image: image)
            }
            .store(in: &cancellable)
        
    }
}
