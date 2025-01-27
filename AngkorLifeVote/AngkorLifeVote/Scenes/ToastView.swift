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
                .font(.kpMedium(.title3))
                .foregroundColor(.black)
            
            Text(message)
                .font(.kpRegular())

            Divider()
                .background(Color.gray.opacity(0.5))
            
            Button(action: confirmAction) {
                Text("Confirm")
                    .font(.kpSemiBold(.headline))
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}
#Preview {
    CustomAlertView(title: "Voting Completed", message: "Thank you for voting", confirmAction: {
    })
}
