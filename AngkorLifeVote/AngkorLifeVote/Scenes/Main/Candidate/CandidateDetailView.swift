//
//  CandidateDetailView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/26/25.
//

import SwiftUI

struct CandidateDetailView: View {
    @ObservedObject var viewModel: CandidateDetailViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.fetchDetail()
                    }
                    .padding()
                }
            } else if let detail = viewModel.candidateDetail {
                ScrollView {
                    VStack(spacing: 20) {
                        profileImagePager(detail.profileInfoList)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(detail.name)
                                .font(.title)
                            Text("Entry No.\(detail.candidateNumber)")
                                .foregroundColor(.blue)
                        }
                        
                        infoCard(detail: detail)
                        
                        Button("Vote") {
                            
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .padding()
                }
                .background(Color.black)
            } else {
                Text("No data")
            }
        }
        .navigationTitle("2024 WMU")
    }
    
    // MARK: - 이미지 Pager
    private func profileImagePager(_ infoList: [ProfileInfo]) -> some View {
        if infoList.isEmpty {
            return AnyView(Color.gray.frame(height: 300))
        }
        
        return AnyView(
            TabView {
                ForEach(infoList, id: \.profileUrl) { info in
                    AsyncImage(url: URL(string: info.profileUrl)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                    .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 300)
        )
    }
    
    // MARK: - 정보 카드
    private func infoCard(detail: CandidateDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            rowItem(title: "Education", value: detail.education)
            rowItem(title: "Major", value: detail.major)
            rowItem(title: "Hobby", value: detail.hobby)
            rowItem(title: "Talent", value: detail.talent)
            rowItem(title: "Ambition", value: detail.ambition)
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(12)
    }
    
    private func rowItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .foregroundColor(.white)
        }
    }
}


#Preview {
    CandidateDetailView(viewModel: CandidateDetailViewModel(id: 48, userID: "", candidateService: CandidateService()))
}
