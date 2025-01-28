//
//  CandidateGridItemView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridItemView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    let candidate: CandidateItem
    let isVoted: Bool
    let action: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                AsyncImage(url: URL(string: candidate.profileUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                        .foregroundStyle(.white)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .onTapGesture {
                    coordinator.selectedCandidate = candidate
                }
            }
            .aspectRatio(1, contentMode: .fit) 

            Text(candidate.name)
                .font(.kpMedium(.headline))
                .foregroundColor(.white)
                .padding(.top)

            Text("\(candidate.voteCnt) Voted")
                .font(.kpMedium())
                .foregroundColor(Color.AK6f76ff)

            Button (action: {action(candidate.id)}) {
                Text(isVoted ? "Voted" : "Vote")
                    .font(.kpBold(size: 16))
                    .foregroundColor(isVoted ? Color.AK4232d5 : .white)
                    .frame(maxWidth: .infinity, maxHeight: 34)
                    .background(isVoted ? .white : Color.AK4232d5)
                    .clipShape(RoundedRectangle(cornerRadius: 999))
                    .frame(maxWidth: .infinity)
            }
            .disabled(isVoted)
        }
    }
}

#Preview {
    CandidateGridItemView(candidate: CandidateItem(id: 1, candidateNumber: 1, name: "GANA", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/52/15668ef9d80e4bc9b05a27defbc6723f.png", voteCnt: "33"), isVoted: true) { _ in }
    .environmentObject(MainCoordinator(appCoordinator: AppCoordinator()))
}
