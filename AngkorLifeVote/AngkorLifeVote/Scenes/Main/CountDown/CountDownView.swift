//
//  CountDownView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CountDownView: View {
    @StateObject private var viewModel: CountDownViewModel = CountDownViewModel()

    var body: some View {
        HStack(spacing: 5) {
            CountDownBlock(number: viewModel.days, unit: "DAY")
            Text(":")
                .font(.title)
                .foregroundColor(.white)
            
            CountDownBlock(number: viewModel.hours, unit: "HR")
            Text(":")
                .font(.title)
                .foregroundColor(.white)
            
            CountDownBlock(number: viewModel.minutes, unit: "MIN")
            Text(":")
                .font(.title)
                .foregroundColor(.white)
            
            CountDownBlock(number: viewModel.seconds, unit: "SEC")
        }
    }
}

struct CountDownBlock: View {
    let number: String
    let unit: String
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Text(number)
                        .font(.kpMedium(.title))
                        .foregroundColor(.gray215)
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                Text(unit)
                    .font(.kpMedium())
                    .foregroundColor(.gray215)
                    .offset(y: proxy.size.width * 0.75) 
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
#Preview {
     CountDownView()
        .environmentObject(AppCoordinator())
}
