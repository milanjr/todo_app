//
//  CommonTextField.swift
//  Todo App
//
//  Created by Milan Rathod on 28/11/25.
//

import SwiftUI

struct CommonTextField: View {
  let placeholder: String
  @Binding var text: String
  var leftView: AnyView? = nil
  var rightView: AnyView? = nil

  var textFieldHeight: CGFloat = 56
  var textFont: Font = Font.body
  var textColor: Color = .black
  var placeholderColor: Color = Color(red: 0.11, green: 0.09, blue: 0.05)
  
  var backgroundColor: Color = Color(red: 0.98, green: 0.98, blue: 0.98)
  var borderColor: Color = .clear
  
  var cornerRadius: CGFloat = 12
  
  var body: some View {
    HStack {
      if let leftView = leftView {
        leftView
      }

      ZStack {
        if text.isEmpty {
          HStack {
            Text(placeholder)
              .font(textFont)
              .foregroundColor(placeholderColor)
            Spacer()
          }
        }
        TextField("", text: $text)
          .font(textFont)
          .foregroundColor(textColor)
      }
      
      if let rightView = rightView {
        rightView
      }
    }
    .padding(16)
    .frame(height: textFieldHeight)
    .background(backgroundColor)
    .cornerRadius(cornerRadius)
    .overlay(
      RoundedRectangle(cornerRadius: cornerRadius)
        .inset(by: 0.50)
        .stroke(borderColor, lineWidth: 0.50)
    )
  }
  
  func textFieldHeight(_ height: CGFloat) -> Self {
    var copy = self
    copy.textFieldHeight = height
    return copy
  }
  
  func textFont(_ font: Font) -> Self {
    var copy = self
    copy.textFont = font
    return copy
  }
  
  func textColor(_ color: Color) -> Self {
    var copy = self
    copy.textColor = color
    return copy
  }
  
  func placeholderColor(_ color: Color) -> Self {
    var copy = self
    copy.placeholderColor = color
    return copy
  }
  
  func backgroundColor(_ color: Color) -> Self {
    var copy = self
    copy.backgroundColor = color
    return copy
  }
  
  func borderColor(_ color: Color) -> Self {
    var copy = self
    copy.borderColor = color
    return copy
  }
  
  func rightView(_ view: some View) -> Self {
    var copy = self
    copy.rightView = AnyView(view)
    return copy
  }
  
  func leftView(_ view: some View) -> Self {
    var copy = self
    copy.leftView = AnyView(view)
    return copy
  }
}

#Preview {
  @Previewable @State var text = ""
  CommonTextField(placeholder: "This is a placeholder", text: $text)

  CommonTextField(placeholder: "This is a placeholder", text: $text)
    .borderColor(.red)
    .placeholderColor(.green)
    .backgroundColor(.yellow.opacity(0.2))
    .rightView(Image("Plus"))
    .leftView(Image("Mic"))
}
