//
//  LocalFileManager.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 16/1/25.
//

import Foundation
import UIKit

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init() {}
    
    /// Saves data to a file in the specified folder.
    /// - Parameters:
    ///   - data: The data to save.
    ///   - fileName: The name of the file (without extension).
    ///   - folderName: The folder to save the file in.
    /// - Throws: An error if the saving process fails.
    func saveData(_ data: Data, fileName: String, folderName: String) throws {
        try createFolderIfNeeded(folderName: folderName)
        
        guard let url = getURLForFile(fileName: fileName, folderName: folderName) else {
            throw LocalFileManagerError.invalidPath
        }
        
        do {
            try data.write(to: url)
        } catch {
            throw LocalFileManagerError.saveFailed(error.localizedDescription)
        }
    }
    
    /// Retrieves data from a file in the specified folder.
    /// - Parameters:
    ///   - fileName: The name of the file (without extension).
    ///   - folderName: The folder containing the file.
    /// - Returns: The data if it exists, or `nil` if not found.
    func getData(fileName: String, folderName: String) -> Data? {
        guard
            let url = getURLForFile(fileName: fileName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return try? Data(contentsOf: url)
    }
    
    /// Deletes a specific file from the specified folder.
    /// - Parameters:
    ///   - fileName: The name of the file to delete (without extension).
    ///   - folderName: The folder containing the file.
    func deleteFile(fileName: String, folderName: String) throws {
        guard let url = getURLForFile(fileName: fileName, folderName: folderName) else {
            throw LocalFileManagerError.invalidPath
        }
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                throw LocalFileManagerError.deleteFailed(error.localizedDescription)
            }
        }
    }
    
    /// Deletes an entire folder and its contents.
    /// - Parameter folderName: The folder to delete.
    func deleteFolder(folderName: String) throws {
        guard let url = getURLForFolder(folderName: folderName) else {
            throw LocalFileManagerError.invalidPath
        }
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                throw LocalFileManagerError.deleteFailed(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func createFolderIfNeeded(folderName: String) throws {
        guard let url = getURLForFolder(folderName: folderName) else {
            throw LocalFileManagerError.invalidPath
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                throw LocalFileManagerError.folderCreationFailed(error.localizedDescription)
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let baseURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return baseURL.appendingPathComponent(folderName)
    }
    
    private func getURLForFile(fileName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(fileName + ".data")
    }
}

// MARK: - Error Types

enum LocalFileManagerError: LocalizedError {
    case invalidPath
    case saveFailed(String)
    case folderCreationFailed(String)
    case deleteFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "Invalid file or folder path."
        case .saveFailed(let message):
            return "Failed to save file: \(message)"
        case .folderCreationFailed(let message):
            return "Failed to create folder: \(message)"
        case .deleteFailed(let message):
            return "Failed to delete file or folder: \(message)"
        }
    }
}
