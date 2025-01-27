//
//  CandidateDetailView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/26/25.
//

import SwiftUI

struct CandidateDetailView: View {
    let candidate: CandidateItem
    @EnvironmentObject var coordinator: MainCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(candidate.name)
                .font(.largeTitle)
                .bold()
            
            Text("Votes: \(candidate.voteCnt)")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Candidate Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    coordinator.logout()
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}


#Preview {
    CandidateDetailView(candidate: CandidateItem(id: 11, candidateNumber: 11, name: "dd", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/48/409425fa12d842e092a4e4db87263009.png", voteCnt: "32"))
}
