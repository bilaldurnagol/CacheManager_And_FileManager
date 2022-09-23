//
//  ContentView.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    
    let imageName: String = "photo"
    var manager = CacheManager.shared
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let startingImage = startingImage else {
            return
        }
        manager.add(with: imageName, image: startingImage)
    }
    
    func removeFromCache() {
        manager.remove(from: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(to: imageName)
    }
    
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
 
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let image = viewModel.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10.0)
                }
                
                HStack {
                    Button {
                        viewModel.saveToCache()
                    } label: {
                        Text("Save to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(8.0)
                    }
                    
                    Button {
                        viewModel.removeFromCache()
                    } label: {
                        Text("Delete to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(8.0)
                    }
                }
                
                Button {
                    viewModel.getFromCache()
                } label: {
                    Text("Fetch to cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(8.0)
                }
                
                if let image = viewModel.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10.0)
                }
                
                Spacer()
            } //: VStack
            .navigationTitle("Cache App")
        .padding(.top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
