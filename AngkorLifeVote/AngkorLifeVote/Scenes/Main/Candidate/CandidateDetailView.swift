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
    @EnvironmentObject var userSession: UserSession
    @Binding var isVoted: Bool
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    if let detail = viewModel.candidateDetail {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                let infoList = viewModel.images
                                if infoList.isEmpty {
                                    Color.gray
                                        .frame(width: proxy.size.width, height: proxy.size.width)
                                } else {
                                    TabView(selection: $viewModel.currentIndex) {
                                        ForEach(Array(infoList.enumerated()), id: \.offset) { (index, info) in
                                            CacheImage(url: info.profileUrl)
                                            .tag(index)
                                        }
                                    }
                                    .frame(width: proxy.size.width, height: proxy.size.width)
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                }
                                
                                // MARK: - 이름 / 번호
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(detail.name)
                                        .font(.kpMedium(.largeTitle))
                                        .foregroundStyle(.white)
                                    Text("Entry No.\(detail.candidateNumber)")
                                        .font(.kpMedium(.headline))
                                        .foregroundColor(Color.AK6f76ff)
                                }
                                .padding()
                                
                                // MARK: - 정보 카드
                                infoCard(detail: detail)
                                    .padding(.horizontal)
                                
                                Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                                    .font(.kpRegular(.caption))
                                    .foregroundStyle(Color.AKbackground)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top)
                                
                                Button(action: {
                                    viewModel.vote()
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
                                    .foregroundStyle(detail.voted ? Color.AK4232d5 : .white)
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(detail.voted ? .white : Color.AK4232d5)
                                    .clipShape(RoundedRectangle(cornerRadius: 999))
                                }
                                .disabled(detail.voted)
                                .padding()
                            }
                        }
                        .background(Color.black)
                    } else if let error = viewModel.errorMessage {
                        VStack {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                            Button("Retry") {
                                viewModel.fetchDetail()
                            }
                            .padding()
                        }
                    } else {
                        Text("No data")
                    }
                }
                if viewModel.showAlert {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                viewModel.showAlert = false
                            }
                        }
                    
                    CustomAlertView(
                        title: viewModel.alertMessage == "Thank you for voting" ? "Voting Completed" : "Voting Failed",
                        message: viewModel.alertMessage ?? "Thank you for voting.",
                        confirmAction: {
                            isVoted = true
                            withAnimation {
                                viewModel.showAlert = false // Alert 닫기
                                viewModel.fetchDetail()
                            }
                        }
                    )
                    .frame(width: proxy.size.width * 0.8)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
                    .zIndex(1) // 다른 뷰들 위에 표시되도록 설정
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
        .background(Color.AK303030)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    private func rowItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.kpMedium(.subheadline))
                .foregroundColor(Color.AK7c7c7c)
            Text(value)
                .font(.kpRegular())
                .foregroundColor(Color.AKf6f6f6)
        }
    }
}

#Preview {
    CandidateDetailView(
        viewModel: CandidateDetailViewModel(
            id: 58,
            userID: "used3dax3rsd2A",
            candidateService: CandidateService()
        ), isVoted: .constant(false)
    )
    .environmentObject(AppCoordinator())
    .environmentObject(UserSession())
}
