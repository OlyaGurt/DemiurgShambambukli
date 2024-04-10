import SwiftUI

// MARK: - CreatorView

struct CreatorView: View {
    @ObservedObject
    var viewStore: CreatorViewStore

    var body: some View {
        switch self.viewStore.state {
        case .initial:
            EmptyView()
        case let .loaded(data):
            VStack {
                Text(data.labelText)
                    .font(.h6)
                    .tracking(15 / 100)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                    .padding(.bottom, 22)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 4) {
                        ForEach(data.cells, id: \.self) { item in
                            if let image = item.image {
                                CellView(
                                    image: image,
                                    icon: item.icon,
                                    title: item.title,
                                    description: item.description
                                )
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 80)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .overlay(alignment: .bottom) {
                SwiftUI.Button(
                    action: {
                        self.viewStore.createLive()
                    },
                    label: {
                        Text(data.buttonText.uppercased())
                            .font(.button)
                            .tracking(1.25)
                            .foregroundColor(.white)
                            .frame(width: 331, height: 36)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 4,
                                    style: .continuous
                                )
                                .fill(Color("purpleLight"))
                            )
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("purple"), .black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(alignment: .top) {
                Color("purpleLight")
                    .background(.regularMaterial)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
        }
    }
}
