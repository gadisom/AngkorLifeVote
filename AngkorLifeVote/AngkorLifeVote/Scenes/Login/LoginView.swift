//
//  LoginView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct LoginView: View {
    @State private var text = ""
    var body: some View {
        GeometryReader { proxy in
            VStack() {
                // 상단 텍스트
                Spacer()
                VStack(spacing: 5) {
                    Text("WORLD MISS UNIVERSITY")
                        .font(.kpMedium(.title))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    Text("CAMBODIA 2024")
                        .font(.kpLight(size: 25))
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Image(.crown)
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width * 0.6)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Text("Cast your vote for the brightest candidate!\nWorld Miss University voting starts now!")
                    .font(.kpExtraLight())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                TextField("Enter your ID", text: $text)
                               .padding()
                               .background(Color(white: 0.1)) // 어두운 배경
                               .foregroundColor(.white) // 텍스트 색상
                               .cornerRadius(8) // 모서리 둥글게
                               .overlay(
                                   RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5) // 테두리 설정
                               )
                               .padding(.horizontal, 20) // 양옆 여백 추가
                Spacer()
            }
        }
        .background(Color.black) // 배경색 설정
        .edgesIgnoringSafeArea(.all) // 화면 전체 사용
    }
}

#Preview {
    LoginView()
}
