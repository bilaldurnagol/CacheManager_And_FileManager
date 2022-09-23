//
//  DownloadingImage.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

struct DownloadingImage: View {
    
    @StateObject var viewModel: ImageLoadingViewModel
    
    init(urlString: String, key: String) {
        _viewModel = StateObject(wrappedValue: ImageLoadingViewModel(urlString: urlString, key: key))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image{
               Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}
