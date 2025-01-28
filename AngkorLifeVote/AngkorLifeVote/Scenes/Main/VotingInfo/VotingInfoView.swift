//
//  VotingInfoView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct VotingInfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("WORLD MISS UNIVERSITY")
                    .foregroundColor(.ak6F76Ff)
                    .font(.kpMedium(.title3))
                
                Text("Mobile Voting Information")
                    .foregroundColor(.white)
                    .font(.kpSemiBold(.largeTitle))
                    .padding(.bottom)
                
                Text("""
                        2024 World Miss University brings 
                        together future global leaders who embody both
                        beauty and intellect.
                        """)
                .foregroundColor(.gray2)
                .font(.kpRegular(size: 14))
                .lineSpacing(5)
            }
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Period")
                        .font(.kpMedium())
                        .foregroundColor(Color.akf6F6F6)
                        .frame(width: 100, alignment: .leading)
                        .padding(.leading)
                    HStack {
                        Text("•")
                            .foregroundStyle(.clear)
                            .font(.title3)
                        Text("10/17(Thu) 12PM - 10/31(Thu) 6PM")
                            .font(.kpRegular(.caption))
                            .foregroundColor(.akdbdbdb)
                    }
                }
                
                .padding(.top)
                
                Divider()
                    .frame(height: 0.4)
                    .background(Color.gray.opacity(0.7))
                    .padding(.horizontal)
                
                HStack(alignment: .top) {
                    VStack{
                        Text("How to vote")
                            .font(.kpMedium())
                            .foregroundColor(Color.akf6F6F6)
                            .frame(width: 100, alignment: .leading)
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
                                .foregroundColor(.akdbdbdb)
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
        }
        .padding()
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

#Preview {
    VotingInfoView()
}
