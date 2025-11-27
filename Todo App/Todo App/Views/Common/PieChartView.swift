//
//  PieChartView.swift
//  Todo App
//
//  Created by Milan Rathod on 27/11/25.
//

import SwiftUI

struct PieChartView: View {
    let data: [(title: String, value: Double)]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(data.indices, id: \.self) { index in
                    let total = data.reduce(0, { $0 + $1.value })
                    let startAngle = (data[0..<index].reduce(0, { $0 + $1.value }) / total * 360)
                    let endAngle = ((data[0...index].reduce(0, { $0 + $1.value }) / total * 360))
                    
                    PieSlice(
                        title: data[index].title,
                        value: data[index].value,
                        startDeg: startAngle,
                        endDeg: endAngle,
                        color: colors[index % colors.count]
                    )
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    private var colors: [Color] {
        [Color("NotUrgentImp"),
         Color("NotUrgentNotImp"),
         Color("UrgentImp"),
         Color("UrgentNotImp"),
          .blue, .green, .orange, .red, .purple, .yellow]
    }
}

struct PieSlice: View {
    let title: String
    let value: Double
    let startDeg: Double
    let endDeg: Double
    let color: Color
    
    var body: some View {
        GeometryReader { proxy in
            let rect = CGRect(origin: .zero, size: proxy.size)
            PieSliceShape(startDeg: startDeg, endDeg: endDeg)
            .fill(color)
            
            // Add label inside the slice
          VStack(spacing: 4) {
            Text(title)
//              .font(FA.font(14))
              .foregroundColor(.white)
            
            Text(String(format: "%.2f%%", value))
//              .font(FA.font(18).weight(.bold))
              .foregroundColor(.white)
          }
          .position(x: rect.midX / 2 * cos(Double.pi * (startDeg + endDeg) / (2 * 180) ) + rect.midX, y: rect.midY / 2 * sin(Double.pi * (startDeg + endDeg) / (2 * 180) ) + rect.midX)
        }
    }
}

// Helper shape for drawing the pie slice
struct PieSliceShape: Shape {
    var startDeg: Double
    var endDeg: Double

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = CGFloat(startDeg) * .pi / 180
        let endAngle = CGFloat(endDeg) * .pi / 180

        var path = Path()
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: Angle(radians: startAngle), endAngle: Angle(radians: endAngle), clockwise: false)
        path.closeSubpath()

        return path
    }
}


#Preview {
  PieChartView(data: [
                  ("Important", 50),
                  ("Hmmm", 50),
                  ("V.Urgent", 80),
                  ("Urgent", 50),
              ])
              .frame(width: 200, height: 200)
}
