//
//  Collabsible.swift
//  TodoList
//
//  Created by Almat Kairatov on 25.12.2022.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State var collapsed: Bool = false
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            .frame(width: .infinity)
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut(duration: 0.45))
            .transition(.slide)
            .disabled(collapsed ? true : false)
        }
    }
}

