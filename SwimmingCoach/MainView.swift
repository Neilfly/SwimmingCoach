//
//  MainView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct MainView: View {
    
    @Binding var showSettings: Bool
    @State var ModeCards = ModeCardArray
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome!")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                HeadView(showSettings: $showSettings)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            //三种不同模式的选择卡片
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20.0) {

                    ForEach(ModeCards.indices) { index in
                        GeometryReader {  geometry in
                            ModeCardView(ModeCards: $ModeCards[index])
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                    
                }
                .padding(30)
                .padding(.top, -10)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSettings: .constant(false))
    }
}

struct ModeCardView: View {
    
    @Binding var ModeCards: ModeCard
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(ModeCards.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(ModeCards.icon)
                    .font(.system(size: 18, weight: .bold))
                    .padding(6)
                    .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.8, blue: 0.9725490196, alpha: 1)))
                    .background(Color(#colorLiteral(red: 0.09803921569, green: 0.1215686275, blue: 0.2901960784, alpha: 1)))
                    .clipShape(Circle())
            }
            
            Text(ModeCards.subtitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LottieView(filename: ModeCards.lottie)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(Color(ModeCards.color))
        .cornerRadius(30)
        .shadow(color: Color(ModeCards.color).opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct ModeCard: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var subtitle: String
    var color: String
    var lottie: String
}

let ModeCardArray = [
    ModeCard(icon: "易", title: "业余游泳\n模式", subtitle: "采用业余数据", color: "c1", lottie: "businessStrategy"),
    ModeCard(icon: "难", title: "专业游泳\n模式", subtitle: "采用专业数据", color: "c3", lottie: "businessTeam"),
    ModeCard(icon: "自", title: "自由游泳\n模式", subtitle: "不进行数据对比", color: "c2", lottie: "socialMedia")
]
