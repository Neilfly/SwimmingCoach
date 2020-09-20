//
//  ModelList.swift
//  SwimmingCoach
//
//  Created by lily on 2020/9/18.
//

import SwiftUI

struct ModelList: View {
    
    @State var cards = CardArray
    @State var active = false
    @State var activeIndex =  -1
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(self.activeView.height / 800))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    HStack {
                        Text("历史记录")
                            .font(.system(size: 30, weight: .bold))
                        
                        Spacer()
                        
//                        Image(systemName: "xmark")
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    .blur(radius: active ? 20 : 0)
                    
                    
                    ForEach(cards.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            ModelCardsView(
                                show: self.$cards[index].show,
                                active: self.$active,
                                activeIndex: self.$activeIndex, activeView: self.$activeView,
                                card: self.cards[index],
                                index: index)
                                .offset(y: self.cards[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.6 : 1)
                                .hueRotation(Angle(degrees: self.activeIndex != index && self.active ? 120 : 0))
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.cards[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.cards[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
}

struct ModelList_Previews: PreviewProvider {
    static var previews: some View {
        ModelList()
    }
}

struct ModelCardsView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var card: Card
    var index: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("详细信息")
                    .font(.title).bold()
                
                Text("您在本次游泳中所用泳姿为蛙泳和自由泳,游泳总时长为 90 分钟，划臂次数 120次，平均配速为 10 公里每小时。")
                    .font(.system(size: 14))
                
                Text("建议")
                    .font(.title).bold()
                
                Text("根据智能算法比对，您的蛙泳划臂动作幅度太小，导致游泳速度慢，请您放开双臂，尽力去划臂和蹬腿。")
                    .font(.system(size: 14))
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 400 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(card.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 160, alignment: .leading)
                            .foregroundColor(.white)
                        
                        Text(card.subtitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                    
                    }
                    Spacer()
                    ZStack {
                        VStack(alignment: .trailing) {
                            Text(show ? "X" : card.icon)
                                .font(.system(size: show ? 28 : 18, weight: .bold))
                                .padding(6)
                                .foregroundColor(show ? Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) : Color(#colorLiteral(red: 0.368627451, green: 0.8, blue: 0.9725490196, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.09803921569, green: 0.1215686275, blue: 0.2901960784, alpha: 1)))
                                .clipShape(Circle())
                                .animation(.easeOut)
                            
                            VStack(alignment: .trailing, spacing: 5.0) {
                                Text(card.date)
                                    .italic()
                                    .foregroundColor(.white)
                                
                                HStack {
                                    Text(String(card.time))
                                        .fontWeight(.bold)
                                    
                                    Text("分钟")
                                        .font(.system(size: 14))
                                }
                                .foregroundColor(.white)
                            }
                            .padding(.top, 10.0)
                            
                        }
                        
//                        VStack {
//                            Image(systemName: "xmark")
//                                .font(.system(size: 16, weight: .medium))
//                                .foregroundColor(.white)
//                        }
//                        .frame(width: 36, height: 36)
//                        .background(Color.black)
//                        .clipShape(Circle())
//                        .opacity(show ? 1 : 0)
                        
                    }
                }
                
                Spacer()
                
                Image("iconfinder_Sports_and_Fitness_swimming_pool_swimmer_6622977")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: show ? 200 : 146, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 400 : 280)
            .background(Color(card.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(card.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                show ?
                DragGesture().onChanged{ value in
                    guard value.translation.height < 300 else {
                        return
                    }
                    guard value.translation.height > 0 else { return }
                        
                        self.activeView = value.translation
                    
                }
                .onEnded{ value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                : nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
//            if show {
//                ModelDetail(card: card, show: $show, active: $active, activeIndex: $activeIndex)
//                    .background(Color.white)
//                    .animation(nil)
//            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1500)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
            DragGesture().onChanged{ value in
                guard value.translation.height < 300 else {return}
                guard value.translation.height > 0 else { return }
                    
                    self.activeView = value.translation
                
            }
            .onEnded{ value in
                if self.activeView.height > 50 {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                }
                self.activeView = .zero
            }
            : nil
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct Card: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var subtitle: String
    var color: String
    var date: String
    var time: Int
    var show: Bool
}

let CardArray = [
    Card(icon: "易", title: "业余游泳\n模式", subtitle: "采用业余数据", color: "c1", date: "8.18, 2020", time: 90, show: false),
    Card(icon: "难", title: "专业游泳\n模式", subtitle: "采用专业数据", color: "c3", date: "8.20, 2020", time: 40, show: false),
    Card(icon: "自", title: "自由游泳\n模式", subtitle: "不进行数据对比", color: "c2", date: "9.10, 2020", time: 80, show: false)
]
