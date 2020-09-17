//
//  Account&SignOutView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct Account_SignOutView: View {
    var body: some View {
        HStack {
            Image(systemName: "gear")
            
            Text("账户")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct Account_SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        Account_SignOutView()
    }
}
