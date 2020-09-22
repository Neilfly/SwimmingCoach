//
//  ModelDetail.swift
//  SwimmingCoach
//
//  Created by lily on 2020/9/19.
//

import SwiftUI

struct ModelDetail: View {
    var card: Card
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0.0) {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture{
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                                self.isScrollable = false
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    Image("iconfinder_Sports_and_Fitness_swimming_pool_swimmer_6622977")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(show ? 30 : 20)
                .padding(.top, show ? 30 : 0)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(card.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(card.color).opacity(0.3), radius: 20, x: 0, y: 20)
                
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
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ModelDetail_Previews: PreviewProvider {
    static var previews: some View {
        ModelDetail(card: CardArray[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(false))
    }
}
