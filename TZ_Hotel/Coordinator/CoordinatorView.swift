//
//  CoordinatorView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 01.10.2023.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .hotel)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    coordinator.pop()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .resizable()
                                        .frame(width: 6, height: 12)
                                        .foregroundColor(Constants.Colors.black)
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                }
                            }
                        }
                }
        }
        .background(Constants.Colors.white)
        .environmentObject(coordinator)
    }
}
