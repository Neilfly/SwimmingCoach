//
//  LoginView.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 22/09/20.
//

import SwiftUI

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessages = "用户名或密码错误!"
    @State var isLoading = false
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top) {
                
                Color("bg2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverHeadView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("用户名".uppercased(), text: $username)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                    Divider()
                        .padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("密码".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)
                
                HStack {
                    Text("忘记密码?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.hideKeyboard()
                        self.isFocused = false
                        self.isLoading = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isLoading = false
                            self.showAlert = true
                        }
                    }) {
                        Text("登陆")
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("错误"), message: Text(self.alertMessages), dismissButton: .default(Text("好的")))
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
            if(isLoading) {
                LoadingView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverHeadView: View {
    @State var shows = false
    @State var dragState = CGSize.zero
    @State var isDrag = false
    
    var body: some View {
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
                    .hueRotation(Angle(degrees: 200))
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
        .background(
            LottieView(filename: "waves", loopMode: .loop)
                .frame(height: 260)
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
