import SwiftUI

// MARK: - CellView

struct CellView: View {
    let image: UIImage
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(uiImage: image)
                .resizable()
                .cornerRadius(50)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .overlay {
                    Text(icon)
                }
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.h6)
                    .tracking(15 / 100)
                    .frame(height: 28)

                Text(description)
                    .font(.boby2)
                    .tracking(1 / 4)
                    .frame(height: 20, alignment: .top)
            }
            .padding(.trailing, 109)

            Spacer()
        }
        .frame(width: 328, height: 72)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
