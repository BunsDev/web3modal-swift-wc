import SwiftUI
import Web3ModalUI

struct WhatIsWalletView: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @EnvironmentObject var router: Router

    var body: some View {
        content()
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.Foreground100)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.Foreground100).withAlphaComponent(0.2)
            }
    }

    func content() -> some View {
        VStack(spacing: 0) {
            if verticalSizeClass == .compact {
                TabView {
                    ForEach(sections(), id: \.title) { section in
                        section
                            .padding(.bottom, 40)
                    }
                }
                .transform {
                    #if os(iOS)
                    $0.tabViewStyle(.page(indexDisplayMode: .always))
                    #endif
                }
                .scaledToFill()
                .layoutPriority(1)

            } else {
                ForEach(sections(), id: \.title) { section in
                    section
                        .padding(.bottom, Spacing.s)
                }
            }

            HStack {
                Button(action: {
                    router.subpage = .getWallet
                }) {
                    HStack {
                        Image.Wallet
                        Text("Get a Wallet")
                    }
                }
            }
            .buttonStyle(W3MButtonStyle(size: .m))
        }
        .padding(.vertical, Spacing.xxl)
        .padding(.horizontal, Spacing.xl)
    }

    func sections() -> [HelpSection] {
        [
            HelpSection(
                title: "A home for your digital assets",
                description: "A wallet lets you store, send and receive digital assets like cryptocurrencies and NFTs.",
                assets: [.imageDeFi, .imageNft, .imageEth]
            ),
            HelpSection(
                title: "One login for all of web3",
                description: "Log in to any app by connecting your wallet. Say goodbye to countless passwords!",
                assets: [.imageLogin, .imageProfile, .imageLock]
            ),
            HelpSection(
                title: "Your gateway to a new web",
                description: "With your wallet, you can explore and interact with DeFi, NFTs, DAOs, and much more.",
                assets: [.imageBrowser, .imageNoun, .imageDao]
            )
        ]
    }
}

struct HelpSection: View {
    let title: String
    let description: String
    let assets: [Image]

    var body: some View {
        VStack(spacing: Spacing.zero) {
            HStack(spacing: Spacing.s) {
                ForEach(assets.indices, id: \.self) { index in
                    assets[index]
                }
            }
            .padding(.bottom, Spacing.xl)

            Text(title)
                .font(.paragraph500)
                .foregroundColor(.Foreground100)
                .multilineTextAlignment(.center)
                .padding(.bottom, Spacing.xs)
            Text(description)
                .font(.small500)
                .foregroundColor(.Foreground200)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, Spacing.s)
        }
    }
}

#if DEBUG
struct WhatIsWalletView_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsWalletView()
    }
}
#endif
