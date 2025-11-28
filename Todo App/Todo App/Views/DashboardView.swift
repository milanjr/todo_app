//
//  DashboardView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI

struct DashboardView: View {
  let taskDistributionData: [DistributionData] = [
    .init(label: "V.Urgent", count: 100),
    .init(label: "Urgent", count: 200),
    .init(label: "Important", count: 300),
    .init(label: "Hmmm", count: 700),
  ]
  
  let taskDistributionColors: [Color] = [
    Color("UrgentImp"),
    Color("UrgentNotImp"),
    Color("NotUrgentImp"),
     Color("NotUrgentNotImp"),
    Color(red: 0, green: 0.88, blue: 0.88)
  ]
  
    var body: some View {
      VStack(spacing: 10) {
        Text("Statistics")
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.blue /*Color("NotUrgentNotImp")*/)
        //          .shadow(radius: 5)
        
        ScrollView {
          VStack(spacing: 10) {
            DashboardFilterView()
              .padding(.horizontal, 20)
            //          .glassEffect()
            
            HStack {
              PieChartView(data: [
                ("Done", 10),
                ("Not Planned", 50),
                ("Planned", 30),
                ("In-Progress", 5),
                ("Canceled", 5),
              ])
              .frame(width: 200)
              .shadow(radius: 10)
              
              VStack {
                LegendView(text: "Done", color: Color("NotUrgentImp"))
                LegendView(text: "Not Planned", color: Color("NotUrgentNotImp"))
                LegendView(text: "Planned", color: Color("UrgentImp"))
                LegendView(text: "In-Progress", color: Color("UrgentNotImp"))
                LegendView(text: "Canceled", color: .blue)
              }
              .frame(maxWidth: 200)
            }
            .frame(height: 200)
            .padding(10)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(16)

            
            VerticalBarGraph(data: taskDistributionData, colors: taskDistributionColors)
              .padding(.horizontal, 20)
              .frame(height: 200)
              .padding(10)
              .background(.white)
              .cornerRadius(20)
              .shadow(radius: 10)
              .padding(.horizontal, 16)
            
            //        Spacer()
            
          }
        }
      }
    }
}

struct DashboardFilterView: View {
  @State var urgency: Int = 0
  @State var importance: Int = 0
  @State var state: Int = 0
  
  @State var fromDate: Date?
  @State var toDate: Date?

  var body: some View {
    VStack(spacing: 10) {
      
      HStack {
        DatePicker(
          "From:",
          selection: Binding($fromDate, replacingNilWith: Date()),
          displayedComponents: [.date]
        )
        
        DatePicker(
          "To:",
          selection: Binding($toDate, replacingNilWith: Date()),
          displayedComponents: [.date]
        )
      }

//      Section(header: Text("Priority")) {
        Picker("Urgency", selection: $urgency) {
          Text("All").tag(0)
          Text("Not Urgent").tag(1)
          Text("Urgent").tag(2)
        }
        .pickerStyle(.segmented)
        
        Picker("Importance", selection: $importance) {
          Text("All").tag(0)
          Text("Not Important").tag(1)
          Text("Important").tag(2)
        }
        .pickerStyle(.segmented)
//      }
//      
//      Section(header: Text("Status")) {
        Picker("Status", selection: $state) {
          Text("All").tag(0)
          Text("Not Planned").tag(1)
          Text("Planned").tag(2)
          Text("In Progress").tag(3)
          Text("On Hold").tag(4)
          Text("Done").tag(5)
          Text("Canceled").tag(6)
        }
//      }
    }
  }
}

struct LegendView: View {
  let text: String
  let color: Color

  var body: some View {
    Text(text)
    .padding(5)
    .background(color)
    .cornerRadius(5)
    .shadow(radius: 2)
  }
}


#Preview {
    DashboardView()
}
