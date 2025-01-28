//
//  CandidateGridItemView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridItemView: View {
    let candidate: CandidateItem
    let isVoted: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                CacheImage(url: candidate.profileUrl)
                    .frame(width: geometry.size.width, height: geometry.size.width)
            }
            .aspectRatio(1, contentMode: .fit) 

            Text(candidate.name)
                .font(.kpMedium(.headline))
                .foregroundColor(.white)
                .padding(.top)

            Text("\(candidate.voteCnt) Voted")
                .font(.kpMedium())
                .foregroundColor(Color.AK6f76ff)

            
            Text(isVoted ? "Voted" : "Vote")
                .font(.kpBold(size: 16))
                .foregroundColor(isVoted ? Color.AK4232d5 : .white)
                .frame(maxWidth: .infinity, maxHeight: 34)
                .background(isVoted ? .white : Color.AK4232d5)
                .clipShape(RoundedRectangle(cornerRadius: 999))
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CandidateGridItemView(candidate: CandidateItem(id: 1, candidateNumber: 1, name: "GANA", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/52/15668ef9d80e4bc9b05a27defbc6723f.png", voteCnt: "33"), isVoted: true)
    .environmentObject(MainCoordinator(appCoordinator: AppCoordinator()))
}
