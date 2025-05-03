//
//  CosmicMorphicSplashScreen.swift
//  SplashViews
//
//  Created by fen0dev on 30/04/2025.
//

import SwiftUI

struct CosmicMorphicSplashScreen: View {
    @State private var phase: CGFloat = 0
    @State private var mutation: CGFloat = 0
    @State private var distortion: CGFloat = 0
    @State private var particles: [Particle] = []
    @State private var bodyTransform: CGFloat = 0
    @State private var morphProgress: CGFloat = 0
    @State private var logoReveal: CGFloat = 0
    @State private var navigateToLogin: Bool = false
    @State private var timer: Timer?
    
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ZStack {
            // Cosmic base
            CosmicBackground()
                .scaleEffect(1.2)
                .blur(radius: 8)
            
            // Liquid mutations layer
            LiquidMutation(phase: phase, mutation: mutation, distortion: distortion)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: "9D4EDD").opacity(0.9),
                            Color(hex: "7B2CBF").opacity(0.9),
                            Color(hex: "5A189A").opacity(0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .blur(radius: 5)
            
            // Particle system
            ForEach(particles) { particle in
                ParticleView(particle: particle, time: phase)
            }
            
            // Warp field effect
            WarpField(distortion: distortion, phase: phase)
                .opacity(0.3)
            
            // Logo formation
            ZStack {
                // Letter C formation
                LetterC(progress: morphProgress)
                    .stroke(
                        LinearGradient(
                            colors: [.white, Color(hex: "9D4EDD")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 5
                    )
                    .frame(width: 100, height: 100)
                    .blur(radius: (1 - morphProgress) * 5)
                    .scaleEffect(0.5 + morphProgress * 0.5)
                    .opacity(morphProgress)
                    .blendMode(.overlay)
                
                // Hollow inner glow
                LetterC(progress: morphProgress)
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 5,
                            endRadius: 50
                        )
                    )
                    .frame(width: 90, height: 90)
                    .opacity(morphProgress * 0.7)
                    .blendMode(.screen)
            }
            .offset(y: -50)
            
            // Brand reveal
            VStack(spacing: 16) {
                Text("Cloober")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color(hex: "9D4EDD")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .opacity(logoReveal)
                    .blur(radius: (1 - logoReveal) * 5)
                    .scaleEffect(0.8 + logoReveal * 0.2)
                
                Text("Experience the Connection")
                    .font(.headline)
                    .foregroundColor(.white.opacity(logoReveal * 0.8))
                    .blur(radius: (1 - logoReveal) * 3)
            }
            .offset(y: 100)
        }
        .onAppear {
            setupParticles()
            startAnimations()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .fullScreenCover(isPresented: $navigateToLogin) {
            //Login
            NavigationStack {
                Text("Welcome Back!")
                    .navigationTitle("Login Page")
            }
        }
    }
    
    func setupParticles() {
        particles = (0..<60).map { _ in
            Particle(
                id: UUID(),
                position: CGPoint(
                    x: CGFloat.random(in: 50...UIScreen.main.bounds.width-50),
                    y: CGFloat.random(in: 50...UIScreen.main.bounds.height-50)
                ),
                size: CGFloat.random(in: 2...6),
                speed: CGFloat.random(in: 0.1...0.4),
                angle: CGFloat.random(in: 0...2*CGFloat.pi),
                lifetime: CGFloat.random(in: 1...3)
            )
        }
    }
    
    func startAnimations() {
        // Liquid mutation timing
        withAnimation(.easeInOut(duration: 12).repeatForever(autoreverses: true)) {
            mutation = 1
        }
        
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            phase = 1
        }
        
        withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
            distortion = 1
        }
        
        // Logo formation sequence
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut(duration: 1.5)) {
                morphProgress = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 1)) {
                logoReveal = 1
            }
        }
        
        // Navigate to login after animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 0.8)) {
                navigateToLogin = true
            }
        }
    }
}
// Particle system
struct Particle: Identifiable {
    let id: UUID
    let position: CGPoint
    var size: CGFloat
    var speed: CGFloat
    var angle: CGFloat
    var lifetime: CGFloat
}

struct ParticleView: View {
    let particle: Particle
    let time: CGFloat
    
    var body: some View {
        let x = particle.position.x + cos(particle.angle + time * 2 * CGFloat.pi) * 20 * particle.speed
        let y = particle.position.y + sin(particle.angle + time * 3 * CGFloat.pi) * 20 * particle.speed
        let opacity = sin(time * CGFloat.pi / particle.lifetime) * 0.7
        
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        Color(hex: "9D4EDD").opacity(opacity),
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: particle.size * 2
                )
            )
            .frame(width: particle.size, height: particle.size)
            .position(x: x, y: y)
            .blur(radius: 0.8)
    }
}

// liquid mutation shape
struct LiquidMutation: Shape {
    var phase: CGFloat
    var mutation: CGFloat
    var distortion: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>> {
        get { AnimatablePair(phase, AnimatablePair(mutation, distortion)) }
        set {
            phase = newValue.first
            mutation = newValue.second.first
            distortion = newValue.second.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Create dynamic blob using multiple sine waves
        path.move(to: CGPoint(x: width/2, y: 0))
        
        for i in 0...100 {
            let t = CGFloat(i) / 100.0
            let angle = t * 2 * CGFloat.pi
            
            // Create complex organic shape
            let r1 = 60 + sin(angle * 6 + phase * 2 * CGFloat.pi) * 30 * mutation
            let r2 = sin(angle * 4 - phase * 3 * CGFloat.pi) * 20 * distortion
            let r3 = sin(angle * 8 + phase * 4 * CGFloat.pi) * 15 * mutation
            let radius = r1 + r2 + r3
            
            // Add position variation
            let x = width/2 + cos(angle) * radius + sin(angle * 3 + phase * CGFloat.pi) * 10 * distortion
            let y = height/2 + sin(angle) * radius + cos(angle * 5 - phase * 2 * CGFloat.pi) * 10 * distortion
            
            // Create smooth curves
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// wrap field effect
struct WarpField: View {
    let distortion: CGFloat
    let phase: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let cols = 8
                let rows = 8
                let stepX = size.width / CGFloat(cols)
                let stepY = size.height / CGFloat(rows)
                
                for i in 0..<cols {
                    for j in 0..<rows {
                        let x = CGFloat(i) * stepX
                        let y = CGFloat(j) * stepY
                        
                        let warp = sin(phase * 2 * CGFloat.pi + CGFloat(i) * 0.5) *
                                   cos(phase * 3 * CGFloat.pi + CGFloat(j) * 0.3) *
                                   20 * distortion
                        
                        let point = CGPoint(x: x + warp, y: y + warp)
                        
                        context.fill(
                            Circle()
                                .path(in: CGRect(
                                    origin: point,
                                    size: CGSize(width: 4, height: 4)
                                )),
                            with: .color(Color(hex: "9D4EDD").opacity(0.3))
                        )
                    }
                }
            }
        }
    }
}

// dynamic letter C
struct LetterC: Shape {
    var progress: CGFloat
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        
        // Start from the right side, go counter-clockwise
        let startAngle = -CGFloat.pi / 6
        let endAngle = CGFloat.pi * 1.33
        let sweepAngle = endAngle - startAngle
        let currentEndAngle = startAngle + sweepAngle * progress
        
        // Create arc for C
        path.addArc(
            center: CGPoint(x: width / 2, y: height / 2),
            radius: radius * 0.8,
            startAngle: Angle(radians: Double(startAngle)),
            endAngle: Angle(radians: Double(currentEndAngle)),
            clockwise: false
        )
        
        // Add inner arc for hollow effect
        if progress > 0.3 {
            let innerProgress = (progress - 0.3) / 0.7
            path.addRelativeArc(
                center: CGPoint(x: width / 2, y: height / 2),
                radius: radius * 0.6,
                startAngle: Angle(radians: Double(currentEndAngle)),
                delta: Angle(radians: Double(-sweepAngle * innerProgress))
            )
        }
        
        return path
    }
}

#Preview {
    CosmicMorphicSplashScreen()
}
