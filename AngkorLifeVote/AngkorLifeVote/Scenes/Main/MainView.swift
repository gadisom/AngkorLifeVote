//
//  MainView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 20) {
                        // 상단 포스터 뷰
                        WmuPosterView()
                            .frame(height: 486)
                        
                        // 카운트다운 섹션
                        CountDownView()
                            .frame(width: proxy.size.width * 0.8, alignment: .center)
                        
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.black)
            }
        }
    }
}




#Preview {
    MainView(viewModel: MainViewModel())
        .environmentObject(UserSession())
    
}
