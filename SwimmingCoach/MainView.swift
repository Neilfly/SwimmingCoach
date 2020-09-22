//
//  MainView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct MainView: View {
    
    @Binding var showSettings: Bool
    @Binding var dragState: CGSize
    @State var ModeCards = ModeCardArray
    @State var HealthyCards = HealthyCardArray
    @State var show = false
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
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
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -getAngleMultipier(bounds: bounds)), axis: (x: 0, y: 10, z: 0))
                                }
                                .frame(width: 275, height: 275)
                            }
                            
                        }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    .offset(y: -20)
                    
                    VStack {
                        HStack {
                            Text("游泳知识")
                                .font(.title).bold()
                            Spacer()
                        }
                        .padding(.leading, 30)
                        .offset(y: -50)
                        
                        ForEach(HealthyCards.indices, id: \.self) { index in
                            HealthCard(HealthyCards: $HealthyCards[index], show: $HealthyCards[index].show)
                                .padding()
                        }
                    }
                    
                }
                .frame(width: screen.width)
                .offset(y: self.showSettings ? -450 : 0)
                .rotation3DEffect(Angle(degrees: self.showSettings ? Double(self.dragState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(self.showSettings ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSettings: .constant(false), dragState: .constant(.zero))
        //            .environment(\.colorScheme, .dark)
        
    }
}

func getAngleMultipier(bounds: GeometryProxy) -> Double {
    if(bounds.size.width > 500) {
        return 80
    }
    else {
        return 20
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

struct HealthCard: View {
    
    @Binding var HealthyCards: HealthyCard
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(HealthyCards.title)
                            .font(.system(size: 28, weight: .bold))
                            .frame(width: 160, alignment: .leading)
                            .foregroundColor(.white)
                        
                        
                        Spacer()
                    }
                    
                    Text(HealthyCards.subtitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size: show ? 18 : 16))
                }
                
                LottieView(filename: HealthyCards.lottie)
                    .frame(height: 200)
            }
            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 300)
        .background(HealthyCards.color)
        .hueRotation(Angle(degrees: show ? 0 : 60))
        .cornerRadius(30)
        .shadow(color: HealthyCards.color.opacity(0.3), radius: 20, x: 0, y: 20)
        .offset(y: -50)
        .onTapGesture {
            self.show.toggle()
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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

struct HealthyCard: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var lottie: String
    var color: Color
    var show: Bool
}

let ModeCardArray = [
    ModeCard(icon: "易", title: "业余游泳\n模式", subtitle: "采用业余数据", color: "c1", lottie: "businessStrategy"),
    ModeCard(icon: "难", title: "专业游泳\n模式", subtitle: "采用专业数据", color: "c3", lottie: "businessTeam"),
    ModeCard(icon: "自", title: "自由游泳\n模式", subtitle: "不进行数据对比", color: "c2", lottie: "socialMedia")
]

let HealthyCardArray = [
    HealthyCard(title: "游泳可以减少血栓出现的可能性", subtitle: "新科研成果", lottie: "blood", color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), show: false),
    HealthyCard(title: "游泳对脑部供血供氧有帮助", subtitle: "临床实验结果", lottie: "brain", color: Color(#colorLiteral(red: 0.7963862419, green: 0.6522253156, blue: 0.471994698, alpha: 1)), show: false),
    HealthyCard(title: "天天游泳对呼吸系统有好处", subtitle: "临床对比结果", lottie: "rationFood", color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), show: false)
]
