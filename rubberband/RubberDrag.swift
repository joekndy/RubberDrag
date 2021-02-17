import SwiftUI

private struct RubberDrag: ViewModifier {
    @State private var yTranslation: CGFloat = .zero
    @State private var xTranslation: CGFloat = .zero

    @State private var isDown = false

    @State var dragLimit: CGFloat

    @State var horizontalEnabled = true
    @State var verticalEnabled = true

    func body(content: Content) -> some View {
        content
            .offset(x: xTranslation, y: yTranslation)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if verticalEnabled {
                            if value.translation.height >= dragLimit {
                                yTranslation = dragLimit * (1.00 + log10(value.translation.height / dragLimit))
                            } else if value.translation.height <= (dragLimit * -1) {
                                yTranslation = (dragLimit * -1) * (1.00 + log10(value.translation.height / (dragLimit * -1)))
                            } else {
                                yTranslation = value.translation.height
                            }
                        }

                        if horizontalEnabled {
                            if value.translation.width >= dragLimit {
                                xTranslation = dragLimit * (1.00 + log10(value.translation.width / dragLimit))
                            } else if value.translation.width <= (dragLimit * -1) {
                                xTranslation = (dragLimit * -1) * (1.00 + log10(value.translation.width / (dragLimit * -1)))
                            } else {
                                xTranslation = value.translation.width
                            }
                        } 

                        isDown = true

                    })
                    .onEnded({ value in
                        isDown = false
                        yTranslation = .zero
                        xTranslation = .zero
                    })
            )
            .animation(isDown ? .none : .interpolatingSpring(stiffness: 140, damping: 20))
    }
}

extension View {
    func rubberDrag(dragLimit: CGFloat, horizontalEnabled: Bool = true, verticalEnabled: Bool = true) -> some View {
        ModifiedContent(
            content: self,
            modifier: RubberDrag(dragLimit: dragLimit, horizontalEnabled: horizontalEnabled, verticalEnabled: verticalEnabled)
        )
    }
}


