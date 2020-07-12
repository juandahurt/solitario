//
//  CardView.swift
//  Solitario
//
//  Created by Negro on 7/07/20.
//  Copyright © 2020 Negro. All rights reserved.
//

import SwiftUI

enum DragState {
    case valid
    case unvalid
    case unknown
}

struct CardView: View {
    @State private var dragAmount = CGSize.zero
    @State private var dragState: DragState = .unknown
    
    var card: Card
    var onEnded: ((Card, CGPoint) -> Void)?
    
    var yOffset: CGFloat?
    
    var body: some View {
        Group {
            if card.isFaceUp {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .background(Color.white.shadow(radius: 2))
                        .cornerRadius(10)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.black)
                    VStack {
                        HStack {
                            Text("\(card.number)")
                                .foregroundColor(.black)
                                .padding(.leading, 5)
                            Spacer()
                            Text(card.suit.symbol)
                            Spacer()
                        }
                        Spacer()
                        Text(card.suit.symbol)
                    }
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .background(Color.black.shadow(radius: 10))
                        .cornerRadius(10)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: 70, height: 100)
        .offset(x: 0, y: yOffset ?? 0)
        .offset(dragAmount)
        .zIndex(dragAmount == .zero ? 0 : 1)
        .gesture(
            DragGesture(coordinateSpace: .global)
            .onChanged() {
                self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
            }
            .onEnded() {
                self.onEnded?(self.card, $0.location)
                self.dragAmount = .zero
            }
        )
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: Card(id: 1, number: 2, suit: .diamonds, location: .stacks(0)))
//    }
//}
