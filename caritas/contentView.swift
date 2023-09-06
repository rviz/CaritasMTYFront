//
//  contentView.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import SwiftUI

struct contentView: View {
    var body: some View {
        TabView{
             detallesView()
             .tabItem {
                 Label("Tickets", systemImage: "ticket")
             }
            detallesView()
             .tabItem {
                 Label("Notifications", systemImage: "bell.badge")
             }
        }.tint(Color(red: 0, green: 156/255, blue: 171/255))
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        contentView()
    }
}
