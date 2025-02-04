//
//  CoinImageService.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 16/1/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    /// Tries to retrieve the image from local storage or downloads it from the API.
    private func getCoinImage() {
        if let savedImageData = fileManager.getData(fileName: imageName, folderName: folderName),
           let savedImage = UIImage(data: savedImageData) {
            image = savedImage
            print("--------> Retrieved image from the local folder! <--------")
        } else {
            downloadCoinImage()
            print("--------> Downloading image from the API. <--------")
        }
    }
    
    /// Downloads the coin image from the API and caches it locally.
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage, let imageData = downloadedImage.pngData() else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                
                do {
                    try self.fileManager.saveData(imageData, fileName: self.imageName, folderName: self.folderName)
                    print("--------> Image saved to local storage! <--------")
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            })
    }
}
