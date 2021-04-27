//
//  ContentView.swift
//  Scan
//
//  Created by Xiaochun Shen on 2021/4/27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var recognizedContent = RecognizedContent()
    @State private var showScanner = false
    @State private var isRecognizing = false
    var body: some View {
        NavigationView {
            List(recognizedContent.items, id: \.id) { textItem in
                Text(String(textItem.text.prefix(50)).appending("..."))
                
            }
        
        
        
        .navigationTitle("Scaner")
        .navigationBarItems(trailing: Button(action: {
            showScanner = true
        }, label: {
            HStack {
                Image(systemName: "doc.text.viewfinder")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Scan")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .frame(height: 36)
            .background(Color(UIColor.systemIndigo))
            .cornerRadius(18)
        }))
    }
    .sheet(isPresented: $showScanner, content: {
        ScannerView { result in
            switch result {
            case .success(let scannedImages):
                isRecognizing = true
                TextRecognition(scannedImges: scannedImages, recognizedContent: recognizedContent) {
                    
                    isRecognizing = false
                }
                .recognizedText()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            showScanner = false
            
        } didCancelScanning: {
            showScanner = false
        }
    })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
