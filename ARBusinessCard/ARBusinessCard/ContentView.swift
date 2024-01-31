//
//  ContentView.swift
//  ARBusinessCard
//
//  Created by Vedant Mistry on 31/01/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    let modelNames: [String] = ["chair_swan", "cup_saucer_set", "pancakes", "tv_retro"]
    @State private var selectedModelIndex: Int = 0
    
    var body: some View {
        VStack {
            ARViewContainer(modelName: modelNames[selectedModelIndex])
                .frame(height: 400)
            
            Picker("Select Model", selection: $selectedModelIndex) {
                ForEach(0..<modelNames.count) { index in
                    HStack {
                        Image(modelNames[index])
                            .resizable()
                            .frame(width: 60, height: 60)
                            .scaledToFit()
                        Spacer()
                        Text(modelNames[index])
                    }
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    let modelName: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()
        
        let modelEntity = try! ModelEntity.loadModel(named: modelName + ".usdz")
        
        let anchorEntity = AnchorEntity()
        anchorEntity.addChild(modelEntity)
        
        anchorEntity.position = [0, 0, -1]
        
        uiView.scene.addAnchor(anchorEntity)
    }
    
}

#Preview {
    ContentView()
}
