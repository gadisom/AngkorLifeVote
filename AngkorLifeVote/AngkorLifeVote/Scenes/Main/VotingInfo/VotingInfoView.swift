//
//  VotingInfoView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct VotingInfoView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(alignment: .leading) {
                    // 상단 타이틀 영역
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WORLD MISS UNIVERSITY")
                            .foregroundColor(.rgb(red: 111, green: 118, blue: 255))
                            .font(.kpMedium(.title3))
                        
                        Text("Mobile Voting Information")
                            .foregroundColor(.white)
                            .font(.kpBold(.largeTitle))
                            .fontWeight(.bold)
                        
                        Text("""
                        2024 World Miss University brings 
                        together future global leaders who embody both
                        beauty and intellect.
                        """)
                        .foregroundColor(.rgb(red: 174, green: 174, blue: 178))
                        .font(.kpRegular(size: 14))
                        .lineSpacing(5)
                    }
                    
                    // 정보 카드 영역
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Period")
                                .font(.kpMedium(size: 16))
                                .foregroundColor(.white)
                                .frame(width: proxy.size.width * 0.28, alignment: .leading)
                                .padding(.leading)
                            HStack {
                                Text("•")
                                    .foregroundStyle(.clear)
                                    .font(.title3)
                                Text("10/17(Thu) 12PM - 10/31(Thu) 6PM")
                                    .font(.kpRegular(.caption))
                                    .foregroundColor(.gray219)
                            }
                        }
                        
                        .padding(.vertical)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.7))
                            .padding(.horizontal)
                        
                        HStack(alignment: .top) {
                            VStack{
                                Text("How to vote")
                                    .font(.kpMedium(.headline))
                                    .foregroundColor(.white)
                                    .frame(width: proxy.size.width * 0.28, alignment: .leading)
                                    .padding(.leading)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(alignment: .top) {
                                    Text("•")
                                        .font(.title3)
                                        .frame(alignment: .top)
                                    Text("Up to three people can participate in early voting per day.")
                                        .font(.kpRegular(.caption))
                                        .padding(.trailing)
                                }
                                HStack(alignment: .top) {
                                    Text("•")
                                    
                                    Text("Three new voting tickets are issued every day at midnight (00:00), and you can vote anew every day during the early voting period.")
                                        .font(.kpRegular(.caption))
                                        .padding(.trailing)
                                }
                            }
                            .padding(.trailing, 3)
                            .foregroundColor(.gray219)
                        }
                        .padding(.vertical)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(Color.white.opacity(0.06))
                    )
                    Spacer()
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.rgb(red: 6, green: 2, blue: 3),
                        Color.rgb(red: 28, green: 28, blue: 28)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .padding(.vertical)
        }
    }
}

#Preview {
    VotingInfoView()
}
