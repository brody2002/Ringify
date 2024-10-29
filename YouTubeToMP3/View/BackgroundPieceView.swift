//
//  BackgroundPieceView.swift
//  YouTubeToMP3
//
//  Created by Brody on 10/29/24.
//

import Foundation
import SwiftUI


struct BackgroundPieceView: View {
    @State var server = ServerCommunicator()
    @State private var textInput: String = ""
    @State private var fileName: String = ""

    var body: some View {
        ZStack {
            Capsule()
                .frame(width:40, height: 400)
                .foregroundColor(Color.black) // Background capsule color
            
            // White Capsule for Link Input
            Capsule()
                .frame(width: 200, height: 60)
                .foregroundColor(Color.white)
                .overlay(
                    TextField("Enter Filename", text: $fileName)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                )
                .offset(y: -100)
            

            // White Capsule for Link Input
            Capsule()
                .frame(width: 300, height: 60)
                .foregroundColor(Color.white)
                .overlay(
                    TextField("Enter Link", text: $textInput)
                        .padding()
                        .frame(width: 280, height: 60)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                )
            


            // Send Button
            Button(action: {
                // Send action
                print("send link")
                server.youtubeLink = textInput
                server.fileName = fileName
                server.sendYouTubeLink { fileURL in
                    if let fileURL = fileURL {
                        print("MP3 saved to: \(fileURL.path)")
                        // Use the file URL as needed, e.g., play the audio or move it to another directory 
                    } else {
                        print("Failed to download and save the MP3 file.")
                    }
                }
            }) {
                Capsule()
                    .frame(width: 120, height: 50)
                    .foregroundColor(Color.white)
                    .overlay(
                        Text("Send")
                            .foregroundColor(.black)
                            .font(.headline)
                    )
            }
            .offset(y: 100)
        }
    }
}


#Preview{
    ZStack{
        Color.red.ignoresSafeArea()
        BackgroundPieceView()
    }
    
}
