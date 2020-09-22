//
//  LoadingView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 22/09/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "trailLoading", loopMode: .loop)
                .frame(width: 200, height: 200)
                .hueRotation(Angle(degrees: 300))
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
