//
//  ToastView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/27/25.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(message)
                .font(.body)
                .foregroundColor(.gray)
            
            Divider()
                .background(Color.gray.opacity(0.5))
            
            Button(action: confirmAction) {
                Text("Confirm")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 40)
    }
}
#Preview {
    CustomAlertView(title: "Voting Completed", message: "Thank you for voting", confirmAction: {
        
    })
}
