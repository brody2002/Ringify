//
//  Server.swift
//  YouTubeToMP3
//
//  Created by Brody on 10/29/24.
//

import Foundation
import UIKit


class ServerCommunicator: NSObject, UIDocumentPickerDelegate {
    var fileName: String
    var youtubeLink: String
    private let serverLink: String = "http://192.168.1.223:5002/convert"
    
    init(fileName: String = "", youtubeLink: String = "") {
            self.fileName = fileName
            self.youtubeLink = youtubeLink
        }
    
    func saveToFilesApp(fileURL: URL) {
        let documentPicker = UIDocumentPickerViewController(forExporting: [fileURL])
        documentPicker.modalPresentationStyle = .formSheet
        documentPicker.delegate = self

        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(documentPicker, animated: true, completion: nil)
        }
    }
    
    func sendYouTubeLink(completion: @escaping (URL?) -> Void) {
        guard let requestUrl = URL(string: serverLink) else { return }
        let requestBody: [String: Any] = ["url": youtubeLink]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else { return }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server returned an error")
                completion(nil)
                return
            }

            if let data = data {
                // Save temporarily in app's cache directory
                let tempDirectoryURL = FileManager.default.temporaryDirectory
                let fileURL = tempDirectoryURL.appendingPathComponent("\(self.fileName).mp3")
                
                do {
                    try data.write(to: fileURL)
                    // Present document picker for user to save in Files app
                    DispatchQueue.main.async {
                        self.saveToFilesApp(fileURL: fileURL)
                    }
                    completion(fileURL)
                } catch {
                    print("File saving error: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Document picker delegate method (if needed)
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled.")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("Document saved to Files app at: \(urls.first?.absoluteString ?? "unknown location")")
    }
}
