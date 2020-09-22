//
//  LoginView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 22/09/20.
//

import SwiftUI

struct LoginView: View {
    
    @State var shows = false
    @State var dragState = CGSize.zero
    @State var isDrag = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Color("bg2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            
            VStack() {
                GeometryReader { geometry in
                    Text("Learn how to swim & healthy.\nFrom here.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(x: dragState.width / 15, y: dragState.height / 15)
                
                Text("多种模式可供选择，让自己游泳的技术提高更快")
                    .font(.subheadline)
                    .frame(width: 250)
                    .offset(x: dragState.width / 20, y: dragState.height / 20)
                
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image("MyBlob")
                        .offset(x: -150, y: -200)
                        .rotationEffect(Angle(degrees: shows ? 360 + 90 : 90))
                        .blendMode(.plusDarker)
                        .animation(
                            Animation
                                .linear(duration: 120)
                                .repeatForever(autoreverses: false)
                        )
                        .onAppear {
                            self.shows = true
                        }
                    
                    Image("MyBlob")
                        .offset(x: -200, y: -250)
                        .rotationEffect(Angle(degrees: shows ? 360 : 0), anchor: .leading)
                        .blendMode(.overlay)
                        .animation(
                            Animation
                                .linear(duration: 100)
                                .repeatForever(autoreverses: false)
                        )
                }
            )
            .background(
                LottieView(filename: "helloLove", loopMode: .playOnce)
                    .frame(height: 220)
                    .offset(x: dragState.width / 25, y: dragState.height / 25)
                , alignment: .bottom
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDrag ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(Angle(degrees: 10), axis: (x: dragState.width, y: dragState.height, z: 0))
            .gesture(
                DragGesture().onChanged { value in
                    self.dragState = value.translation
                    self.isDrag = true
                }
                .onEnded { value in
                    self.dragState = .zero
                    self.isDrag = false
                }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
