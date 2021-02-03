//
//  PhotoService.swift
//  vkApp
//
//  Created by Влад Голосков on 24.01.2021.
//  Copyright © 2021 Владислав Голосков. All rights reserved.
//

import Foundation
import Alamofire

class PhotoService {
    //Словарь для кэша изображений
    private var images = [String: UIImage]()
    
    private let cacheLifeTime: TimeInterval = 1 * 24 * 60 * 60
    private static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    //Преобразование URL в путь к файлу
    func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    //Сохранение изображение в файловую систему
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async { [self] in
            images[url] = image
        }
        return image
    }
    
    private func getPhotoFromURL(at indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: .global(), completionHandler: { [weak self] response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                
                DispatchQueue.main.async {
                    self?.images[url] = image
                    self?.container.reloadRow(atIndexpath: indexPath)
                }
                
                self?.saveImageToCache(url: url, image: image)
            }
            
        })
    }
    
    func photo(at indexPath: IndexPath, by url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            getPhotoFromURL(at: indexPath, byUrl: url)
        }
        
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
}