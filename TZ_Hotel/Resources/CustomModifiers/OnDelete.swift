//
//  OnDelete.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 08.10.2023.
//

import SwiftUI

struct Delete: ViewModifier {
    let action: () -> Void

    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false

    // MARK: Constants

    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(100)

    // MARK: body

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    deleteView(geometry: geometry)
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance, !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance, willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        if offset.width < -deletionDistance {
                            delete()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                        } else {
                            offset = .zero
                            initialOffset = .zero
                        }
                    }
            )
            .animation(.easeOut, value: willDeleteIfReleased)
    }

    private func delete() {
        offset.width = -contentWidth
        action()
        offset = .zero
        initialOffset = .zero
        willDeleteIfReleased = false
        contentWidth = 0.0
    }

    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    @ViewBuilder private func deleteView(geometry: GeometryProxy) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.red)
            Image(systemName: "trash")
                .foregroundColor(.white)
                .font(.title2.bold())
                .layoutPriority(-1)
        }
        .frame(width: -offset.width)
        .offset(x: geometry.size.width)
        .onAppear {
            contentWidth = geometry.size.width
        }
        .gesture(
            TapGesture()
                .onEnded {
                    delete()
                }
        )
    }
}

extension View {
    func onDelete(perform action: @escaping () -> Void) -> some View {
        modifier(Delete(action: action))
    }
}
