import SwiftUI

struct ConnectWalletView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Button(action: {
                router.setRoute(Router.ConnectingSubpage.qr)
            }, label: {
                Text("WalletConnect")
            })
            .buttonStyle(W3MListSelectStyle(
                imageContent: {
                    ZStack {
                        Color.Blue100
                        
                        Image.imageLogo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    }
                },
                tag: W3MTag(title: "QR Code", variant: .main)
            ))
            
            ForEach(store.featuredWallets, id: \.self) { wallet in
                Button(action: {
                    router.setRoute(Router.ConnectingSubpage.walletDetail(wallet))
                }, label: {
                    Text(wallet.name)
                })
                .buttonStyle(W3MListSelectStyle(
                    imageContent: {
                        Image(
                            uiImage: store.walletImages[wallet.imageId]
                            ?? UIImage(named: "Wallet", in: .module, compatibleWith: nil)
                            ?? UIImage()
                        
                        )
                        .resizable()
                        .background(.Overgray005)
                        .overlay {
                            RoundedRectangle(cornerRadius: Radius.xxxs)
                                .strokeBorder(.Overgray010, lineWidth: 1)
                        }
                    }
                ))
            }
                
            Button(action: {
                router.setRoute(Router.ConnectingSubpage.allWallets)
            }, label: {
                Text("All wallets")
            })
            .buttonStyle(W3MListSelectStyle(
                imageContent: {
                    Image.optionAll
                },
                tag: store.totalNumberOfWallets != 0 ? W3MTag(title: "\(store.totalNumberOfWallets)+", variant: .info) : nil
            ))
        }
        .padding(Spacing.s)
        .padding(.bottom)
    }
}

struct ConnectWalletView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectWalletView()
    }
}