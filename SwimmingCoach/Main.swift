//
//  Main.swift
//  SwimmingCoach
//
//  Created by 张雨飞 on 17/09/20.
//

import SwiftUI

struct Main: View {
    
    @State var showSettings = false
    @State var dragState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color("bg2").edgesIgnoringSafeArea(.all)
            
            MainView(showSettings: $showSettings)
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("bg2"), Color("bg1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        
                        Spacer()
                    }
                    .background(Color("bg1"))
                )
//                .foregroundColor(Color("bg1"))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showSettings ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showSettings ? Double(dragState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showSettings ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            
            AccountSignOutView()
                .background(Color.black.opacity(0.001))
                .offset(y: showSettings ? 0 : screen.height)
                .offset(y: dragState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showSettings.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragState = value.translation
                    }
                    .onEnded { value in
                        if(self.dragState.height > 50) {
                            self.showSettings = false
                        }
                        self.dragState = .zero
                    }
                )
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .environment(\.colorScheme, .dark)
    }
}

struct HeadView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View {
        Button(action: {
            self.showSettings.toggle()
        }) {
            Image("head")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
//                .background(Color("bg3"))
        }
    }
}

let screen = UIScreen.main.bounds
