//
//  MainView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct MainView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome!")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                HeadView(showSettings: $showSettings)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            //三种不同模式的选择卡片
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30.0) {
                    //业余模式
                    VStack {
                        HStack(alignment: .top) {
                            Text("业余游泳\n模式")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 160, alignment: .leading)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("易")
                                .font(.system(size: 18, weight: .bold))
                                .padding(6)
                                .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.8, blue: 0.9725490196, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.09803921569, green: 0.1215686275, blue: 0.2901960784, alpha: 1)))
                                .clipShape(Circle())
                        }
                        
                        Text("采用业余数据")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LottieView(filename: "businessStrategy")
                            .frame(width: 210)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .frame(width: 275, height: 275)
                    .background(Color("c1"))
                    .cornerRadius(30)
                    .shadow(color: Color("c1").opacity(0.3), radius: 20, x: 0, y: 20)
                    
                    //专业模式
                    VStack {
                        HStack(alignment: .top) {
                            Text("专业游泳\n模式")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 160, alignment: .leading)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("难")
                                .font(.system(size: 18, weight: .bold))
                                .padding(6)
                                .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.8, blue: 0.9725490196, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.09803921569, green: 0.1215686275, blue: 0.2901960784, alpha: 1)))
                                .clipShape(Circle())
                        }
                        
                        Text("采用业余数据")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LottieView(filename: "businessTeam")
                            .frame(width: 210)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .frame(width: 275, height: 275)
                    .background(Color("c3"))
                    .cornerRadius(30)
                    .shadow(color: Color("c3").opacity(0.3), radius: 20, x: 0, y: 20)
                    
                    //自由模式
                    VStack {
                        HStack(alignment: .top) {
                            Text("自由游泳\n模式")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 160, alignment: .leading)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("自")
                                .font(.system(size: 18, weight: .bold))
                                .padding(6)
                                .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.8, blue: 0.9725490196, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.09803921569, green: 0.1215686275, blue: 0.2901960784, alpha: 1)))
                                .clipShape(Circle())
                        }
                        
                        Text("采用业余数据")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LottieView(filename: "socialMedia")
                            .frame(width: 210)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .frame(width: 275, height: 275)
                    .background(Color("c2"))
                    .cornerRadius(30)
                    .shadow(color: Color("c2").opacity(0.3), radius: 20, x: 0, y: 20)
                }
                .padding(30)
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
