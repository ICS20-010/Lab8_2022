//
//  ContentView.swift
//  Lab8_2022
//
//  Created by ICS 224 on 2022-03-01.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State var score: UInt = 0
    var body: some View {
        VStack {
            let ar = ARViewContainer(score: $score)
            ar.edgesIgnoringSafeArea(.all)
            Text("Score: \(score)")
            Button("Play") {
                ar.callOrbit()
            }
        }
    }

}

struct ARViewContainer: UIViewRepresentable {
    @Binding var score: UInt
    let worldAnchor = try! Experience.loadWorld()
    
    func callOrbit() -> Void {
        worldAnchor.notifications.orbitBoard.post()
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        self.worldAnchor.actions.ballWasHit.onAction = { entity in
            if entity?.name == "ball" {
                score += 1
            }
        }
        // Add the box anchor to the scene
        arView.scene.anchors.append(worldAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
