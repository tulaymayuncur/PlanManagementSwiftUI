//
//  ContentView.swift
//  PlanManager
//
//  Created by Tülay MAYUNCUR on 22.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
