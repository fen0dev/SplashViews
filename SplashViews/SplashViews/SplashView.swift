//
//  SplashView.swift
//  SplashViews
//
//  Created by fen0dev on 28/04/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isAnimating: Bool = false
    @State private var showText: Bool = false
    @State private var rotationAngle: Double = 0
    @State private var scaleEffect: CGFloat = 0.5
    @State private var fadeOpacity: Double = 0
    @Environment(\.colorScheme) private var scheme
    
    @State private var navigateToLogin: Bool = false
    
    var body: some View {
        ZStack {
            // Cosmic background
            CosmicBackground()
            
            VStack(spacing: 30) {
                // Animated Logo/Icon
                ZStack {
                    // Outer glow ring
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "9D4EDD").opacity(0.6),
                                    Color(hex: "7B2CBF").opacity(0.6)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(rotationAngle))
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .blur(radius: 2)
                    
                    // Inner logo circle
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "7B2CBF"),
                                    Color(hex: "5A189A")
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                        .scaleEffect(scaleEffect)
                        .shadow(
                            color: Color(hex: "9D4EDD").opacity(0.5),
                            radius: 15,
                            x: 0,
                            y: 5
                        )
                    
                    // Icon/Letter inside
                    Text("C")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(fadeOpacity)
                }
                
                // App name
                VStack(spacing: 8) {
                    Text("Cloober")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 10)
                    
                    Text("Cosmic connections await")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 10)
                }
                
                // Loading animation
                GeometryReader { geometry in
                    LoadingDots()
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height / 2
                        )
                }
                .frame(height: 100)
            }
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
        .onAppear {
            startAnimations()
        }
        .fullScreenCover(isPresented: $navigateToLogin) {
            //Login
            NavigationStack {
                Text("Welcome Back!")
                    .navigationTitle("Login Page")
            }
        }
    }
    
    func startAnimations() {
        // Logo animation
        withAnimation(.easeInOut(duration: 1)) {
            scaleEffect = 1.0
            fadeOpacity = 1.0
        }
        
        // Rotation animation
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
        
        // Glow animation
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            isAnimating.toggle()
        }
        
        // Text animation
        withAnimation(.easeInOut(duration: 0.8).delay(0.5)) {
            showText = true
        }
        
        // Navigate to login after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                navigateToLogin = true
            }
        }
    }
}

// Fallback loading dots animation
struct LoadingDots: View {
    @State private var animation1: Bool = false
    @State private var animation2: Bool = false
    @State private var animation3: Bool = false
    
    private let color = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "9D4EDD"),
            Color(hex: "7B2CBF")
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .scaleEffect(animation1 ? 1.5 : 1)
                .opacity(animation1 ? 0.5 : 1)
                .animation(.easeInOut(duration: 0.6).repeatForever(), value: animation1)
            
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .scaleEffect(animation2 ? 1.5 : 1)
                .opacity(animation2 ? 0.5 : 1)
                .animation(.easeInOut(duration: 0.6).repeatForever().delay(0.2), value: animation2)
            
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .scaleEffect(animation3 ? 1.5 : 1)
                .opacity(animation3 ? 0.5 : 1)
                .animation(.easeInOut(duration: 0.6).repeatForever().delay(0.4), value: animation3)
        }
        .onAppear {
            animation1 = true
            animation2 = true
            animation3 = true
        }
    }
}

#Preview {
    SplashView()
}

