//
//  MainView.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      TabView {

          EisenhowerMatrixView()
              .tabItem {
                  Image(systemName: "square.grid.2x2")
                  Text("Matrix")
              }
              .padding(.horizontal, 16)
              .padding(.bottom, 16)

          TaskListView()
              .tabItem {
                  Image(systemName: "checklist")
                  Text("Tasks")
              }
              .background(.pink)
              .padding(.horizontal, 16)
              .padding(.bottom, 16)

          DashboardView()
              .tabItem {
                  Image(systemName: "chart.bar")
                  Text("Dashboard")
              }
              .background(.purple)
              .padding(.horizontal, 16)
              .padding(.bottom, 16)

          SettingsView()
              .tabItem {
                  Image(systemName: "gear")
                  Text("Settings")
              }
              .background(.green)
              .padding(.horizontal, 16)
              .padding(.bottom, 16)
      }
  }
}

#Preview {
    MainView()
}
