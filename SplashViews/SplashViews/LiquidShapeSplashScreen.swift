//
//  LiquidShapeSplashScreen.swift
//  SplashViews
//
//  Created by fen0dev on 01/05/2025.
//

import SwiftUI

struct LiquidShapeSplashScreen: View {
    @State private var phase: CGFloat = 0
    @State private var mutation: CGFloat = 0
    @State private var distortion: CGFloat = 0
    @State private var navigateToLogin: Bool = false
    
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ZStack {
            // Base cosmic background
            CosmicBackground()
                .scaleEffect(1.2)
                .blur(radius: 5)
            
            // Metaball physics system
            CosmicMorphicSplashScreen.MetaballSystem(phase: phase, mutation: mutation)
                .blur(radius: 2)
                .opacity(0.7)
            
            // Quantum ripple at center
            CosmicMorphicSplashScreen.QuantumRipple(
                phase: phase,
                center: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - 50)
            )
            .blendMode(.screen)
            
            // Cosmic tendrils
            CosmicMorphicSplashScreen.CosmicTendrils(phase: phase, distortion: distortion)
                .opacity(0.5)
                .blendMode(.overlay)
            
            // Main logo formation
            VStack(spacing: 20) {
                // Dynamic logo
                Text("C")
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color(hex: "9D4EDD")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color(hex: "9D4EDD").opacity(0.5), radius: 10, x: 0, y: 5)
                    .scaleEffect(1 + sin(phase * 2 * CGFloat.pi) * 0.1)
                
                Text("Cloober")
                    .font(.system(size: 36, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(min(1, phase * 2))
                    .blurEffect(radius: (1 - min(1, phase * 2)) * 5)
            }
            .offset(y: -50)
        }
        .onAppear {
            startAdvancedAnimations()
        }
        .fullScreenCover(isPresented: $navigateToLogin) {
            //Login
            NavigationStack {
                Text("Welcome Back!")
                    .navigationTitle("Login Page")
            }
        }
    }
    
    func startAdvancedAnimations() {
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            phase = 1
        }
        
        withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
            mutation = 1
        }
        
        withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
            distortion = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 0.8)) {
                //navigateToLogin = true
            }
        }
    }
}

// Blur modifier extension
extension View {
    func blurEffect(radius: CGFloat) -> some View {
        self.blur(radius: radius)
    }
}

#Preview {
    LiquidShapeSplashScreen()
}

extension CosmicMorphicSplashScreen {
    
    // Metaball physics simulation
    struct MetaballSystem: View {
        let phase: CGFloat
        let mutation: CGFloat
        
        private let ballCount = 12
        private let threshold: CGFloat = 0.3
        
        var body: some View {
            Canvas { context, size in
                let resolution = 60
                var field = Array(repeating: Array(repeating: CGFloat(0), count: resolution), count: resolution)
                
                // Calculate metaball field
                for x in 0..<resolution {
                    for y in 0..<resolution {
                        let px = CGFloat(x) / CGFloat(resolution) * size.width
                        let py = CGFloat(y) / CGFloat(resolution) * size.height
                        
                        var fieldValue: CGFloat = 0
                        
                        for i in 0..<ballCount {
                            let angle = CGFloat(i) / CGFloat(ballCount) * 2 * CGFloat.pi
                            let amplitude = 50 + CGFloat(i) * 8
                            
                            let bx = size.width/2 + cos(angle + phase * 2 * CGFloat.pi) * amplitude
                            let by = size.height/2 + sin(angle - phase * 3 * CGFloat.pi) * amplitude
                            
                            let dx = px - bx
                            let dy = py - by
                            let distance = sqrt(dx*dx + dy*dy)
                            
                            if distance > 0 {
                                fieldValue += 1500 / (distance * distance)
                            }
                        }
                        
                        field[x][y] = fieldValue
                    }
                }
                
                // Draw metaball shape
                var path = Path()
                let stepX = size.width / CGFloat(resolution)
                let stepY = size.height / CGFloat(resolution)
                
                // March through field and create contours
                for x in 0..<resolution-1 {
                    for y in 0..<resolution-1 {
                        let v1 = field[x][y]
                        let v2 = field[x+1][y]
                        let v3 = field[x+1][y+1]
                        let v4 = field[x][y+1]
                        
                        // Check if threshold is crossed
                        if (v1 < threshold) != (v2 < threshold) {
                            let px = CGFloat(x) * stepX + (threshold - v1) / (v2 - v1) * stepX
                            let py = CGFloat(y) * stepY
                            path.addLine(to: CGPoint(x: px, y: py))
                        }
                        
                        if (v2 < threshold) != (v3 < threshold) {
                            let px = CGFloat(x+1) * stepX
                            let py = CGFloat(y) * stepY + (threshold - v2) / (v3 - v2) * stepY
                            path.addLine(to: CGPoint(x: px, y: py))
                        }
                        
                        if (v3 < threshold) != (v4 < threshold) {
                            let px = CGFloat(x+1) * stepX - (threshold - v3) / (v4 - v3) * stepX
                            let py = CGFloat(y+1) * stepY
                            path.addLine(to: CGPoint(x: px, y: py))
                        }
                        
                        if (v4 < threshold) != (v1 < threshold) {
                            let px = CGFloat(x) * stepX
                            let py = CGFloat(y+1) * stepY - (threshold - v4) / (v1 - v4) * stepY
                            path.addLine(to: CGPoint(x: px, y: py))
                        }
                    }
                }
                
                context.fill(path, with: .linearGradient(
                    Gradient(colors: [
                        Color(hex: "9D4EDD").opacity(0.9),
                        Color(hex: "7B2CBF").opacity(0.9),
                        Color(hex: "5A189A").opacity(0.9)
                    ]),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: size.width, y: size.height)
                ))
                
                context.addFilter(.shadow(
                    color: Color(hex: "9D4EDD").opacity(0.3),
                    radius: 15,
                    x: 0,
                    y: 5
                ))
            }
        }
    }
    
    // Gravity-defying tendrils
    struct CosmicTendrils: View {
        let phase: CGFloat
        let distortion: CGFloat
        
        var body: some View {
            Canvas { context, size in
                let tendrilCount = 16
                
                for i in 0..<tendrilCount {
                    var path = Path()
                    let startAngle = CGFloat(i) / CGFloat(tendrilCount) * 2 * CGFloat.pi
                    
                    // Start from center
                    let startX = size.width / 2
                    let startY = size.height / 2
                    
                    path.move(to: CGPoint(x: startX, y: startY))
                    
                    // Create tendril with 20 segments
                    for segment in 1...20 {
                        let t = CGFloat(segment) / 20.0
                        let radius = t * 100 * (1 + distortion * 0.5)
                        
                        // Complex wave pattern for tendril
                        let angleOffset = sin(t * 4 * CGFloat.pi + phase * 2 * CGFloat.pi) * 0.3 +
                                          cos(t * 8 * CGFloat.pi - phase * 3 * CGFloat.pi) * 0.2
                        
                        let currentAngle = startAngle + angleOffset
                        
                        let x = startX + cos(currentAngle) * radius
                        let y = startY + sin(currentAngle) * radius
                        
                        // Add control points for smooth curves
                        if segment > 1 {
                            let prevT = CGFloat(segment - 1) / 20.0
                            let prevRadius = prevT * 100 * (1 + distortion * 0.5)
                            let prevX = startX + cos(startAngle) * prevRadius
                            let prevY = startY + sin(startAngle) * prevRadius
                            
                            let controlX = (prevX + x) / 2 + cos(currentAngle + CGFloat.pi/2) * 10
                            let controlY = (prevY + y) / 2 + sin(currentAngle + CGFloat.pi/2) * 10
                            
                            path.addQuadCurve(
                                to: CGPoint(x: x, y: y),
                                control: CGPoint(x: controlX, y: controlY)
                            )
                        }
                    }
                    
                    // Create gradient stroke
                    let opacity = 0.5 - CGFloat(i) / CGFloat(tendrilCount) * 0.3
                    let width = 1.5 - CGFloat(i) / CGFloat(tendrilCount)
                    
                    context.stroke(
                        path,
                        with: .linearGradient(
                            Gradient(colors: [
                                Color(hex: "9D4EDD").opacity(opacity),
                                Color(hex: "7B2CBF").opacity(opacity * 0.7),
                                Color.clear
                            ]),
                            startPoint: CGPoint(x: startX, y: startY),
                            endPoint: CGPoint(x: startX + 100, y: startY + 100)
                        ),
                        lineWidth: width
                    )
                }
            }
        }
    }
    
    // Quantum ripple effect
    struct QuantumRipple: View {
        let phase: CGFloat
        let center: CGPoint
        
        @State private var ripplePhase: CGFloat = 0
        
        var body: some View {
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    for i in 0..<8 {
                        let rippleSize = CGFloat(i) * 40 + ripplePhase * 200
                        let opacity = 1.0 - (CGFloat(i) / 8.0 + ripplePhase)
                        
                        if opacity > 0 {
                            let path = Path(ellipseIn: CGRect(
                                x: center.x - rippleSize/2,
                                y: center.y - rippleSize/2,
                                width: rippleSize,
                                height: rippleSize
                            ))
                            
                            context.stroke(
                                path,
                                with: .linearGradient(
                                    Gradient(colors: [
                                        Color(hex: "9D4EDD").opacity(opacity),
                                        Color(hex: "7B2CBF").opacity(opacity * 0.5),
                                        Color.clear
                                    ]),
                                    startPoint: CGPoint(x: center.x - rippleSize/4, y: center.y - rippleSize/4),
                                    endPoint: CGPoint(x: center.x + rippleSize/4, y: center.y + rippleSize/4)
                                ),
                                lineWidth: 2
                            )
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                    ripplePhase = 1
                }
            }
        }
    }
}
