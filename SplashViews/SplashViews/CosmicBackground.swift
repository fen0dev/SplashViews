//
//  CosmicBackground.swift
//  SplashViews
//
//  Created by fen0dev on 27/04/2025.
//

import SwiftUI

struct CosmicBackground: View {
    @Environment(\.colorScheme) private var scheme
    
    private let cosmicPositions: [(CGFloat, CGFloat, CGFloat)] = {
        var positions = [(CGFloat, CGFloat, CGFloat)]()
        for _ in 0..<8 {
            let x = CGFloat.random(in: -200...200)
            let y = CGFloat.random(in: -400...400)
            let size = CGFloat.random(in: 80...240)
            positions.append((x, y, size))
        }
        return positions
    }()
    var body: some View {
        ZStack {
            // base gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    scheme == .dark ? Color(hex: "0D0221") : Color(hex: "E9D9FF"),
                    scheme == .dark ? Color(hex: "190B33") : Color(hex: "D0B9FF"),
                    scheme == .dark ? Color(hex: "271A45") : Color(hex: "BCA1FE"),
                    scheme == .dark ? Color(hex: "#11031F") : Color(hex: "#2A1E36")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            // fixed cosmic elements
            ForEach(0..<cosmicPositions.count, id:\.self) { i in
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                scheme == .dark ? Color(hex: "9D4EDD").opacity(0.7) : Color(hex: "7B2CBF").opacity(0.4),
                                scheme == .dark ? Color(hex: "7B2CBF").opacity(0.1) : Color(hex: "9D4EDD").opacity(0.1)
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: cosmicPositions[i].2 / 2
                        )
                    )
                    .frame(width: cosmicPositions[i].2)
                    .offset(
                        x: cosmicPositions[i].0,
                        y: cosmicPositions[i].1
                    )
                    .blur(radius: 30)
            }
            
            // subtle overlay texture for depth
            Rectangle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            scheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.2)
                        ]),
                        center: .center,
                        startRadius: 100,
                        endRadius: 600
                    )
                )
                .ignoresSafeArea()
        }
    }
}

#Preview {
    CosmicBackground()
}


// extension to create colors form hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
