//
//  ContentView.swift
//  YouTubeToMP3
//
//  Created by Brody on 10/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .teddybear
    
    private var screenTitle: String {
            switch tabSelected {
            case .gearshape:
                return "Settings"
            case .teddybear:
                return "Convert"
            case .folder:
                return "Ringtones"
            }
        }
        
        var body: some View {
            ZStack {
                Color.red.ignoresSafeArea()
                
               
                
                
                VStack {
                    Spacer()
                    
                    Text("\(screenTitle)")
                        .animation(nil, value: tabSelected)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 40))
                        
                    
                    
                    
                    Spacer()
                    ZStack{
                        if tabSelected == .teddybear{
                            BackgroundPieceView()
                        }
                    }.frame(width: 400, height: 400)
                    
                    Spacer()
                    Spacer()
                    CustomTabBar(selectedTab: $tabSelected)
                }
                
                
            }
        }
}

#Preview {
    ContentView()
                
}


