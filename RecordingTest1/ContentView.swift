//
//  ContentView.swift
//  RecordingTest1
//
//  Created by Joey Rubin on 10/12/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var audioManager = AudioManager()
        @State private var isRecording = false

        var body: some View {
            VStack {
                Button(action: {
                    if isRecording {
                        audioManager.stopRecording()
                    } else {
                        audioManager.startRecording()
                    }
                    
                    isRecording.toggle()
                }) {
                    Text(isRecording ? "Stop Recording" : "Start Recording")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

                List(audioManager.recordings, id: \.self) { url in
                    Button(action: {
                        audioManager.playAudio(url: url)
                    }) {
                        Text(url.lastPathComponent)
                    }
                }
            }
            .padding()
        }
}

#Preview {
    ContentView()
}
