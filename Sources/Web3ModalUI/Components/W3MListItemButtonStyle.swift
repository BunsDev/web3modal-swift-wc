import SwiftUI

public struct W3MListItemButtonStyle<ImageContent: View>: ButtonStyle {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.isEnabled) var isEnabled

    @ScaledMetric var scale: CGFloat = 1

    var imageContent: () -> ImageContent
    var showChevron: Bool = false
    @Binding var isLoading: Bool

    var isPressedOverride: Bool?

    #if DEBUG
        init(
            @ViewBuilder imageContent: @escaping () -> ImageContent,
            showChevron: Bool,
            isLoading: Binding<Bool>,
            isPressedOverride: Bool? = nil
        ) {
            self.imageContent = imageContent
            _isLoading = isLoading
            self.showChevron = showChevron
            self.isPressedOverride = isPressedOverride
        }
    #endif

    public func makeBody(configuration: Configuration) -> some View {
        AdaptiveStack(
            condition: dynamicTypeSize.isAccessibilitySize,
            horizontalAlignment: .center,
            spacing: Spacing.s
        
        ) {
            imageComponent()

            configuration.label

            if !dynamicTypeSize.isAccessibilitySize {
                Spacer()
            }

            Group {
                if isLoading {
                    CircleProgressView(
                        color: .Blue100,
                        lineWidth: 2 * scale,
                        isAnimating: $isLoading
                    )
                    .frame(width: 15 * scale, height: 15 * scale)
                } else if showChevron {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.Foreground200)
                }
                
            }
        }
        .font(.paragraph600)
        .foregroundColor(.Foreground100)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 56)
        .opacity(isEnabled ? 1 : 0.5)
        .padding(.vertical, Spacing.xs * scale)
        .padding(.leading, Spacing.s * scale)
        .padding(.trailing, Spacing.l * scale)
        .background((isPressedOverride ?? configuration.isPressed) ? .Overgray010 : .Overgray005)
        .cornerRadius(Radius.s * scale)
        .allowsHitTesting(!isLoading)
    }

    @ViewBuilder
    func imageComponent() -> some View {
        imageContent()
            .frame(maxWidth: 32 * scale, maxHeight: 32 * scale)
            .aspectRatio(contentMode: .fit)
            .saturation(isEnabled ? 1 : 0)
            .opacity(isEnabled ? 1 : 0.5)
            .cornerRadius(Radius.xxxs * scale)
    }
}

#if DEBUG
    public struct W3MListItemButtonStylePreviewView: View {
        
        @Environment(\.dynamicTypeSize) var dynamicTypeSize
        
        public init() {}

        public var body: some View {
            ScrollView {
                VStack {
                    Button(action: {}, label: {
                        AdaptiveStack(condition: dynamicTypeSize.isAccessibilitySize, spacing: 5) {
                            Text("0.527 ETH")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: true,
                        isLoading: .constant(false),
                        isPressedOverride: nil
                    ))
                    
                    Button(action: {}, label: {
                        AdaptiveStack(condition: dynamicTypeSize.isAccessibilitySize, spacing: 5) {
                            Text("W/ CHEVRON")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: true,
                        isLoading: .constant(false),
                        isPressedOverride: nil
                    ))

                    Button(action: {}, label: {
                        HStack(spacing: 5) {
                            Text("W/O CHEVRON")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: false,
                        isLoading: .constant(false),
                        isPressedOverride: nil
                    ))

                    Button(action: {}, label: {
                        HStack(spacing: 5) {
                            Text("LOADING")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: true,
                        isLoading: .constant(true),
                        isPressedOverride: nil
                    ))

                    Button(action: {}, label: {
                        HStack(spacing: 5) {
                            Text("DISABLED")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: true,
                        isLoading: .constant(false),
                        isPressedOverride: nil
                    ))
                    .disabled(true)

                    Button(action: {}, label: {
                        HStack(spacing: 5) {
                            Text("PRESSED")
                            
                            Text("607.38 USD")
                                .foregroundColor(.Foreground200)
                        }
                    })
                    .buttonStyle(W3MListItemButtonStyle(
                        imageContent: {
                            Image.imageEth
                                .resizable()
                                .clipShape(Circle())
                        },
                        showChevron: true,
                        isLoading: .constant(false),
                        isPressedOverride: true
                    ))
                }
                .padding()
                .background(.Overgray002)
            }
        }
    }

    struct W3MListItem_Preview: PreviewProvider {
        static var previews: some View {
            W3MListItemButtonStylePreviewView()
                .previewLayout(.sizeThatFits)
        }
    }

#endif
