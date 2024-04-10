import SwiftUI

@main
struct DemiurgShambambukliApp: App {
    var body: some Scene {
        WindowGroup {
            CreatorView(viewStore: CreatorViewStore(store: CreatorStore()))
        }
    }
}
