//
//  CandidateDetailView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/26/25.
//

import SwiftUI

struct CandidateDetailView: View {
    @ObservedObject var viewModel: CandidateDetailViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    var body: some View {
        GeometryReader { proxy in
            VStack {
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
                        VStack(alignment: .leading ,spacing: 20) {
                            let infoList = viewModel.images
                            if infoList.isEmpty {
                                Color.gray
                                    .frame(width: proxy.size.width, height: proxy.size.width)
                            } else {
                                TabView(selection: $viewModel.currentIndex) {
                                    ForEach(Array(infoList.enumerated()), id: \.offset) { (index, info) in
                                        AsyncImage(url: URL(string: info.profileUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .tag(index)
                                    }
                                }
                                .frame(width: proxy.size.width, height: proxy.size.width)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            }
                            
                            // MARK: - 이름 / 번호
                            VStack(alignment: .leading, spacing: 4) {
                                Text(detail.name)
                                    .font(.kpSemiBold(.largeTitle))
                                    .foregroundStyle(.white)
                                Text("Entry No.\(detail.candidateNumber)")
                                    .font(.kpMedium(.headline))
                                    .foregroundColor(.rgb(red: 111, green: 118, blue: 255))
                            }
                            .padding()
                            
                            // MARK: - 정보 카드
                            infoCard(detail: detail)
                                .padding(.horizontal)
                            
                            Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                                .font(.kpRegular(.caption))
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button(action: {
                                // 투표 로직 등
                            }) {
                                
                                HStack(spacing: 4) {
                                    if detail.voted {
                                        Image(.voted)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                    }
                                    Text(detail.voted ? "Voted" : "Vote")
                                        .font(.kpBold(.title3))
                                }
                                .foregroundColor(detail.voted ? .accent : .white)
                                .frame(maxWidth: .infinity, minHeight: 48)
                                .background(detail.voted ? .white : .accent)
                                .clipShape(RoundedRectangle(cornerRadius: 999))

                            }
                            .padding()
                        }
                    }
                    .background(Color.black)
                } else {
                    Text("No data")
                }
            }
        }
        .navigationTitle("2024 WMU")
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
    
    // MARK: - 정보 카드
    private func infoCard(detail: CandidateDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            rowItem(title: "Education", value: detail.education)
            Divider()
            rowItem(title: "Major", value: detail.major)
            Divider()
            rowItem(title: "Hobbies", value: detail.hobby)
            Divider()
            rowItem(title: "Talent", value: detail.talent)
            Divider()
            rowItem(title: "Ambition", value: detail.ambition)
        }
        .padding()
        .background(Color.rgb(red: 37, green: 37, blue: 37))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    private func rowItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.kpMedium(.subheadline))
                .foregroundColor(.gray)
            Text(value)
                .font(.kpRegular())
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CandidateDetailView(
        viewModel: CandidateDetailViewModel(
            id: 48,
            userID: "userA",
            candidateService: CandidateService()
        )
    )
    .environmentObject(AppCoordinator())
}
