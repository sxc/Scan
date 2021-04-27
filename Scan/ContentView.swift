//
//  ContentView.swift
//  Scan
//
//  Created by Xiaochun Shen on 2021/4/27.
//

import SwiftUI

struct ContentView: View {
    @State private var showScanner = false
    var body: some View {
        NavigationView {
            Text("Hello, world!")
                .padding()
        
        
        
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
            case .success(let scannedPages):
                break
                
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
