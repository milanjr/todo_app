//
//  SettingsView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI

struct SettingsView: View {
  @State private var urgentImpColor: Color = Color("UrgentImp")
  @State private var urgentNotImpColor: Color = Color("UrgentNotImp")
  @State private var notUrgentImpColor: Color = Color("NotUrgentImp")
  @State private var notUrgentNotImpColor: Color = Color("NotUrgentNotImp")

  @State private var notPlannedColor: Color = .gray
  @State private var plannedColor: Color = .pink
  @State private var inProgressColor: Color = .blue
  @State private var onHoldColor: Color = .orange
  @State private var doneColor: Color = .green
  @State private var canceledColor: Color = .gray.opacity(0.8)
  
  @State private var message = ""

  var body: some View {
    VStack(spacing: 20) {
      Text("Settings")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.blue)
      
      HStack {
        Button {
          urgentImpColor = Color("UrgentImp")
          urgentNotImpColor = Color("UrgentNotImp")
          notUrgentImpColor = Color("NotUrgentImp")
          notUrgentNotImpColor = Color("NotUrgentNotImp")
          
          notPlannedColor = .gray
          plannedColor = .pink
          inProgressColor = .blue
          onHoldColor = .orange
          doneColor = .green
          canceledColor = .gray.opacity(0.8)
          
          message = ""
          
        } label: {
          Text("Reset Colors")
            .padding(10)
            .padding(.horizontal, 10)
            .background(.red)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(20)
            .shadow(radius: 5)

        }

        Spacer()
        
        Button {
          debugPrint("Save colors in SwiftData")
          message = "It will not work yet. Please use the Xcode scheme to save the colors."
        } label: {
          Text("Save")
            .padding(10)
            .padding(.horizontal, 10)
            .background(.blue)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(20)
            .shadow(radius: 5)
            
        }

      }
      
      ScrollView {
        VStack(spacing: 10) {
          
          ColorSelectionView(text: "Urgent Important", color: $urgentImpColor)
          ColorSelectionView(text: "Urgent Not Important", color: $urgentNotImpColor)
          ColorSelectionView(text: "Not Urgent Important", color: $notUrgentImpColor)
          ColorSelectionView(text: "Not Urgent Not Important", color: $notUrgentNotImpColor)
          //
          //      ColorSelectionView(text: "Not Planned", color: notPlannedColor)
          //      ColorSelectionView(text: "Planned", color: plannedColor)
          //      ColorSelectionView(text: "In Progress", color: inProgressColor)
          //      ColorSelectionView(text: "On Hold", color: onHoldColor)
          //      ColorSelectionView(text: "Done", color: doneColor)
          //      ColorSelectionView(text: "Canceled", color: canceledColor)
          
//          ColorPicker("Urgent Important", selection: $urgentImpColor, supportsOpacity: false)
//          ColorPicker("Urgent Not Important", selection: $urgentNotImpColor, supportsOpacity: false)
//          ColorPicker("Not Urgent Important", selection: $notUrgentImpColor, supportsOpacity: false)
//          ColorPicker("Not Urgent Not Important", selection: $notUrgentNotImpColor, supportsOpacity: false)
          
          ColorPicker("Not Planned", selection: $notPlannedColor, supportsOpacity: false)
          ColorPicker("Planned", selection: $plannedColor, supportsOpacity: false)
          ColorPicker("In Progress", selection: $inProgressColor, supportsOpacity: false)
          ColorPicker("On Hold", selection: $onHoldColor, supportsOpacity: false)
          ColorPicker("Done", selection: $doneColor, supportsOpacity: false)
          ColorPicker("Canceled", selection: $canceledColor, supportsOpacity: false)
          
          Text(message)
            .foregroundColor(.red)
        }
      }
    }
    .padding(.horizontal, 20)
  }
}

struct ColorSelectionView: View {
  let text: String
  @Binding var color: Color
  
  var body: some View {
    HStack(spacing: 10) {
//      Spacer()
//      Text(text)
      ColorPicker(text, selection: $color, supportsOpacity: false)

      Spacer()
//      Button(action: {
//      }) {
        Rectangle()
          .fill(color)
          .frame(width: 100, height: 30)
          .cornerRadius(8)
//      }
    }
//    .padding(10)
    .background(.white)
    .cornerRadius(8)
    
  }
}
#Preview {
    SettingsView()
}
