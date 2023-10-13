//
//  AudioManager.swift
//  RecordingTest1
//
//  Created by Joey Rubin on 10/12/23.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @Published var recordings: [URL] = []
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true)
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioURL = documentPath.appendingPathComponent(UUID().uuidString).appendingPathExtension("m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.record()
            
        } catch {
            print("Failed to record.")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recordings.append(audioRecorder.url)
    }
    
    func playAudio(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
            print("audio playing", url)
        } catch {
            print("Failed to play audio.")
        }
    }
}

