//
//  DownloadingImageView.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

struct DownloadingImageView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel = DownloadingImageViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.datas) { data in
                    DownloadingImagesRow(item: data)
                }
            }
            .navigationTitle("Downloading Image")
        }
    }
}

// MARK: - Preview
struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView()
    }
}
