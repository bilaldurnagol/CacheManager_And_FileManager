//
//  DownloadingImagesRow.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    // MARK: - Properties
    
    var item: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImage(urlString: item.url, key: String(item.id))
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading,spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.url)
                    .foregroundColor(.gray)
                    .italic()
            }
        }
    }
}
