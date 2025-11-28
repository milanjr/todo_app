//
//  VerticalBarGraph.swift
//  Todo App
//
//  Created by Milan Rathod on 27/11/25.
//

import SwiftUI
import Charts

struct VerticalBarGraph: View {
  let data: [DistributionData]
  let colors: [Color]
  
//  var axisFont: Font = Font("axisFontName", size: 10)
  var axisTextColor: Color = Color(red: 0.29, green: 0.45, blue: 0.61)
  
  var body: some View {
    Chart {
      ForEach(Array(data.enumerated()), id: \.element.id) {index, x in
        BarMark(
          x: .value("Label", x.label),
          y: .value("Value", x.count)
        )
        .annotation(content: {
          Text("\(x.count)")
        })
        .foregroundStyle(colors[index % colors.count])
        .cornerRadius(10)
        .shadow(radius: 5)
        
      }
    }
    .chartXAxis {
      AxisMarks(position: .bottom) { value in
        AxisValueLabel {
          if let labelText = value.as(String.self) {
            Text(labelText)
              .font(.caption)
              .fontWeight(.bold)
              .foregroundColor(axisTextColor)
          }
        }
      }
    }
    .chartYAxis {}
  }
}

#Preview {
  let taskDistributionData: [DistributionData] = [
    .init(label: "V.Urgent", count: 1200),
    .init(label: "Urgent", count: 1800),
    .init(label: "Important", count: 2200),
    .init(label: "Hmmm", count: 1800),
  ]
  
  let taskDistributionColors: [Color] = [
    Color("UrgentImp"),
    Color("UrgentNotImp"),
    Color("NotUrgentImp"),
     Color("NotUrgentNotImp"),
    Color(red: 0, green: 0.88, blue: 0.88)
  ]
  
  VerticalBarGraph(data: taskDistributionData, colors: taskDistributionColors)
}
