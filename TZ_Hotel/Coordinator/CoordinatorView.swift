//
//  CoordinatorView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 01.10.2023.
//

import SwiftUI

struct CoordinatorView: View
{
    @StateObject private var coordinator = Coordinator()
    var body: some View
    {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .hotel)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .background(Constants.Colors.white)
        .environmentObject(coordinator)
        
    }
}


