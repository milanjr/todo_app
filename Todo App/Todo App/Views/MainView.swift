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

          TaskListView()
              .tabItem {
                  Image(systemName: "checklist")
                  Text("Tasks")
              }

          DashboardView()
              .tabItem {
                  Image(systemName: "chart.bar")
                  Text("Dashboard")
              }

          SettingsView()
              .tabItem {
                  Image(systemName: "gear")
                  Text("Settings")
              }
      }
  }
}

#Preview {
    MainView()
}
