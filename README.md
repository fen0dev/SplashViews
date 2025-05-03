# 🌌 SwiftUI Splash Screens - Animation Masterclass

A comprehensive collection of SwiftUI splash screens showcasing progressive animation complexity, from beginner to advanced levels. Perfect for developers looking to enhance their animation skills and create stunning app intros.

![Splash Screen Demo](https://img.shields.io/badge/SwiftUI-5.9+-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2015+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📑 Table of Contents

- Overview
    Level 1: Basic Animated Splash Screen
    Level 2: Advanced Liquid Mutation
    Level 3: Mind-Bending Metaball Physics
    Installation
    Usage
    Learning Objectives
    Contributing
    License
    Credits

## 🌟 Overview

This repository contains three progressive levels of splash screen implementations, each demonstrating increasing complexity in SwiftUI animations and visual effects. Perfect for:

- 📚 Learning SwiftUI animation techniques
- 💼 Portfolio projects
- 🎨 Inspiring creative UI implementations
- 🏋️‍♂️ Animation skill building exercises

## 🟢 Level 1: Basic Animated Splash Screen

### Key Features:
- Rotating logo with glow effect
- Fade-in text animations
- Progressive scale effects
- Simple Lottie integration
- Cosmic background gradient

### Visual Description:
A purple-themed cosmic background with a rotating central logo, animated dots loading indicator, and smooth text appearances. Transitions to the login screen after 3.5 seconds.

### Techniques Used:
1. **Basic Animations**
   - `withAnimation` modifiers
   - Scale and opacity transformations
   - Rotation effects with repeat forever

2. **UI Components**
   - Custom cosmic button styles
   - Gradient backgrounds
   - Shadow effects

### Code Preview:
```swift
struct SplashView: View {
    @State private var isAnimating: Bool = false
    @State private var scaleEffect: CGFloat = 0.5
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            CosmicBackground()
            
            VStack(spacing: 30) {
                // Rotating logo
                Circle()
                    .fill(purpleGradient)
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(rotationAngle))
                    .scaleEffect(scaleEffect)
                
                Text("Cloober")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1 : 0)
                
                LoadingDots()
            }
        }
        .onAppear {
            startAnimations()
        }
    }
}
```

### Learning Objectives:
- Master basic SwiftUI animations
- Understand animation timing and easing
- Implement custom loading indicators
- Create smooth view transitions

## 🟡 Level 2: Advanced Liquid Mutation

### Key Features:
- Dynamic liquid shape deformation
- Particle system physics
- Warp field effects
- Advanced gradient animations
- Progressive letter formation

### Visual Description:
A morphing cosmic blob with organic movement, surrounded by floating particles. The letter "C" forms through a complex animation sequence, with space-time warping effects in the background.

### Techniques Used:
1. **Advanced Shape Animation**
   ```swift
   struct LiquidMutation: Shape {
       var phase: CGFloat
       var mutation: CGFloat
       var distortion: CGFloat
       
       var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>> {
           get { AnimatablePair(phase, AnimatablePair(mutation, distortion)) }
           set { ... }
       }
       
       func path(in rect: CGRect) -> Path {
           // Complex sine wave calculations for organic shapes
           var path = Path()
           for i in 0...100 {
               let t = CGFloat(i) / 100.0
               let angle = t * 2 * CGFloat.pi
               
               let r1 = 60 + sin(angle * 6 + phase * 2 * CGFloat.pi) * 30 * mutation
               let r2 = sin(angle * 4 - phase * 3 * CGFloat.pi) * 20 * distortion
               let radius = r1 + r2
               
               // Create smooth curves...
           }
           return path
       }
   }
   ```

2. **Particle Physics**
   - Individual particle lifecycle management
   - Orbital motion algorithms
   - Opacity fade-based on lifetime
   - Blur effects for depth

3. **Advanced Gradients**
   - RadialGradient animations
   - LinearGradient with AnimatableData
   - Blend modes (overlay, screen)

### Learning Objectives:
- Master AnimatableData protocol
- Implement custom Shape protocol
- Create particle systems
- Understand blend modes and visual effects

## 🔴 Level 3: Mind-Bending Metaball Physics

### Key Features:
- Real-time metaball physics simulation
- Quantum ripple effects
- Cosmic tendrils with procedural generation
- Complex field calculations
- Advanced Canvas rendering

### Visual Description:
A mesmerizing metaball system that creates organic, fluid shapes. Quantum ripples expand from the center while cosmic tendrils flow outward. The background warps with space-time effects, creating a truly otherworldly experience.

### Techniques Used:
1. **Metaball Physics Engine**
   ```swift
   struct MetaballSystem: View {
       let phase: CGFloat
       let mutation: CGFloat
       
       var body: some View {
           Canvas { context, size in
               var field = Array(repeating: Array(repeating: CGFloat(0), count: resolution), count: resolution)
               
               // Calculate metaball field
               for x in 0..<resolution {
                   for y in 0..<resolution {
                       let px = CGFloat(x) / CGFloat(resolution) * size.width
                       let py = CGFloat(y) / CGFloat(resolution) * size.height
                       
                       var fieldValue: CGFloat = 0
                       
                       for i in 0..<ballCount {
                           let bx = calculateBallPosition(i, phase)
                           let by = calculateBallPosition(i, phase)
                           
                           let distance = sqrt(dx*dx + dy*dy)
                           fieldValue += 1500 / (distance * distance)
                       }
                       
                       field[x][y] = fieldValue
                   }
               }
               
               // March through field and create contours
               // Draw metaball shape using threshold crossing
           }
       }
   }
   ```

2. **Quantum Ripple System**
   - TimelineView for real-time animation
   - Concentric circle generation
   - Gradient opacity calculations
   - Screen blend mode for luminous effects

3. **Procedural Tendrils**
   ```swift
   struct CosmicTendrils: View {
       let phase: CGFloat
       let distortion: CGFloat
       
       var body: some View {
           Canvas { context, size in
               for i in 0..<tendrilCount {
                   var path = Path()
                   
                   for segment in 1...20 {
                       let t = CGFloat(segment) / 20.0
                       let radius = t * 100 * (1 + distortion * 0.5)
                       
                       // Complex wave patterns
                       let angleOffset = sin(t * 4 * CGFloat.pi + phase * 2 * CGFloat.pi) * 0.3
                       
                       // Add control points for smooth curves
                       path.addQuadCurve(...) 
                   }
                   
                   // Gradient stroke rendering
               }
           }
       }
   }
   ```

### Learning Objectives:
- Master Canvas rendering
- Implement physics simulations
- Create procedural animation systems
- Understand field calculations and marching algorithms

## 🚀 Installation

### Prerequisites:
- Xcode 15.0+
- iOS 15.0+
- SwiftUI 5.9+

### Setup:
1. Create a new SwiftUI project
2. Copy the desired level's files into your project
3. Import required frameworks:
   ```swift
   import SwiftUI
   import Lottie  // For Level 1 (optional)
   ```
4. Add your hex color extension if not already present

## 💻 Usage

### Basic Implementation:
```swift
struct ContentView: View {
    @AppStorage("log_status") private var logStatus: Bool = false
    
    var body: some View {
        if logStatus {
            HomeView()
        } else {
            // Choose your splash screen level:
            SplashView()          // Level 1
            // AdvancedSplashView()  // Level 2
            // UltraAdvancedSplashView() // Level 3
        }
    }
}
```

### Customization Options:

1. **Colors**: Modify the hex values in the gradients
2. **Timing**: Adjust animation durations in `startAnimations()`
3. **Effects**: Toggle blur radius and opacity values
4. **Physics**: Modify particle counts and speeds

## 📚 Learning Objectives

### Level 1: Foundations
- [ ] Basic SwiftUI animations
- [ ] View transitions
- [ ] Custom loading indicators
- [ ] Gradient implementations
- [ ] Navigation patterns

### Level 2: Intermediate
- [ ] AnimatableData protocol
- [ ] Custom Shape creation
- [ ] Particle systems
- [ ] Advanced timing functions
- [ ] Blend modes and effects

### Level 3: Advanced
- [ ] Canvas rendering
- [ ] Physics simulations
- [ ] Field calculations
- [ ] Procedural generation
- [ ] Performance optimization

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Guidelines:
1. Follow SwiftUI best practices
2. Comment complex animations thoroughly
3. Include visual descriptions for new effects
4. Test on multiple iOS versions
5. Maintain the cosmic theme

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎉 Credits

Created with ❤️ by fen0dev

### Inspiration:
- Apple's SwiftUI documentation
- Metaball algorithms from computer graphics literature
- Particle system designs from game development

## 🌟 Show Your Support

If this project helped you, please give it a ⭐️ on GitHub!

## 📞 Contact

For questions or collaborations:
- GitHub: [@fen0dev](https://github.com/fen0dev)
- Email: giuseppedemasi.inq@gmail.com

---

Made with 💫 for the SwiftUI community
