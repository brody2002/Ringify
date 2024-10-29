//
//  CustomTabBar.swift
//  YouTubeToMP3
//
//  Created by Brody on 10/29/24.
//

import Foundation



import SwiftUI

enum Tab: String, CaseIterable {
    case gearshape
    case teddybear
    case folder
    
    
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    private var tabColor: Color {
        switch selectedTab {
        case .gearshape:
            return .white
        case .teddybear:
            return .white
        case .folder:
            return .white
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .black)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}

#Preview{
    CustomTabBar(selectedTab: .constant(.teddybear))
}
