//
//  Tabbar.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView {
            Main().tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("主页")
                }
            
            //格式一样另外一页
            ModelList().tabItem {
                Image(systemName: "timer")
                Text("历史")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
