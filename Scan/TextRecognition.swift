//
//  TextRecognition.swift
//  Scan
//
//  Created by Xiaochun Shen on 2021/4/27.
//

import Foundation
import SwiftUI
import Vision

struct TextRecognition {
    var scannedImges: [UIImage]
    @ObservedObject var recognizedContent: RecognizedContent
    var disdFinishRecognition: () -> Void
    
    
    private func getTextRecognitionRequest(with textItem: TextItem) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            observations.forEach { observation in
                guard let recognizedText = observation.topCandidates(1).first else { return }
                
                textItem.text += recognizedText.string
                textItem.text += "\n"
            }
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        return request
    }
    
    func recognizedText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            for image in scannedImges {
                guard let cgImage = image.cgImage  else { return }
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    let textItem = TextItem()
                    try requestHandler.perform([getTextRecognitionRequest(with: textItem)])
                    DispatchQueue.main.async {
                        recognizedContent.items.append(textItem)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                disdFinishRecognition()
            }
        }
    }
}
