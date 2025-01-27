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
                            profileImagePager(detail.profileInfoList)
                                .frame(width: proxy.size.width, height: proxy.size.width)
                        
                            VStack(alignment: .leading, spacing: 4) {
                                Text(detail.name)
                                    .font(.kpSemiBold(.largeTitle))
                                    .foregroundStyle(.white)
                                Text("Entry No.\(detail.candidateNumber)")
                                    .font(.kpMedium(.headline))
                                    .foregroundColor(.rgb(red: 111, green: 118, blue: 255))
                            }
                            .padding()
                            
                            infoCard(detail: detail)
                                .padding(.horizontal)
                            
                            Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                                .font(.kpRegular(.caption))
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button(action: {
                                
                            }) {
                                Text("Vote")
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.accent)
                            .foregroundColor(.white)
                            .cornerRadius(999)
                        }
                    }
                    .background(Color.black)
                } else {
                    Text("No data")
                }
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
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
        )
    }
    
    // MARK: - 정보 카드
    private func infoCard(detail: CandidateDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            rowItem(title: "Education", value: detail.education)
            Divider()
            rowItem(title: "Major", value: detail.major)
            Divider()
            rowItem(title: "Hobby", value: detail.hobby)
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
    CandidateDetailView(viewModel: CandidateDetailViewModel(id: 48, userID: "", candidateService: CandidateService()))
}
