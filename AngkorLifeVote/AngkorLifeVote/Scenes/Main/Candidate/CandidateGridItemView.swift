//
//  CandidateGridItemView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridItemView: View {
    let candidate: CandidateItem
    let onVote: (CandidateItem) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            // 프로필 사진
            AsyncImage(url: URL(string: candidate.profileUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .aspectRatio(1, contentMode: .fit)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // 이름
            Text(candidate.name)
                .font(.kpMedium(.headline))
                .foregroundColor(.white)
            
            // voteCnt
            Text("\(candidate.voteCnt) Voted")
                .font(.kpRegular())
                .foregroundColor(.rgb(red: 111, green: 118, blue: 255))
            
            // 투표 버튼
            Button(action: {
                onVote(candidate)
            }) {
                Text("Vote")
                    .foregroundColor(.white)
                    .background(.accent)
                    .frame(maxWidth: .infinity, maxHeight: 34)
                    .clipShape(RoundedRectangle(cornerRadius: 999))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

