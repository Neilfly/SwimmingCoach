//
//  Account&SignOutView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct Account_SignOutView: View {
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing: 30.0) {
                SettingRow(title: "修改信息", icon: "gearshape")
                SettingRow(title: "退出登陆", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(radius: 30)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
    }
}

struct Account_SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        Account_SignOutView()
    }
}

struct SettingRow: View {
    
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
            
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .frame(width: 120, alignment: .leading)
        }
    }
}
