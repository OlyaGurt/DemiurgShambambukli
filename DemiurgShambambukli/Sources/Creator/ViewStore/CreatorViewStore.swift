import Combine
import SwiftUI

final class CreatorViewStore: ObservableObject {
    // MARK: Lifecycle

    init(store: CreatorStore) {
        self.store = store
        self.setupObservers()
    }

    // MARK: Internal

    enum State: Hashable {
        case initial
        case loaded(data: StateData)

        // MARK: Internal

        struct StateData: Hashable {
            struct CellData: Hashable {
                let image: UIImage?
                let icon: String
                let title: String
                let description: String
            }

            let cells: [CellData]
            let labelText: String
            let buttonText: String
        }
    }

    @Published
    var state: State = .initial

    func createLive() {
        self.store.createLive()
    }

    // MARK: Private

    private enum Const {
        static let deadTitle = "Мёртвая"
        static let aliveTitle = "Живая"
        static let lifeTitle = "Жизнь"

        static let deadDescription = "или прикидывается"
        static let aliveDescription = "и шевелится!"
        static let lifeDescription = "Ку-ку"

        static let deadImage = UIImage(named: "deadImage")
        static let aliveImage = UIImage(named: "aliveImage")
        static let lifeImage = UIImage(named: "lifeImage")

        static let deadIcon = "💀"
        static let aliveIcon = "💥"
        static let lifeIcon = "🐣"

        static let labelText = "Клеточное наполнение"
        static let buttonText = "Сотворить"
    }

    private let store: CreatorStore

    private var disposeBag: Set<AnyCancellable> = []

    private func setupObservers() {
        self.store.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.processState(state)
            }
            .store(in: &self.disposeBag)
    }

    private func processState(_ state: CreatorStore.State) {
        switch state {
        case .initial:
            self.updateState(.initial)
        case let .loaded(data):
            let cellsData = data.compactMap { cellType in
                switch cellType {
                case .dead:
                    State.StateData.CellData(
                        image: Const.deadImage,
                        icon: Const.deadIcon,
                        title: Const.deadTitle,
                        description: Const.deadDescription
                    )
                case .alive:
                    State.StateData.CellData(
                        image: Const.aliveImage,
                        icon: Const.aliveIcon,
                        title: Const.aliveTitle,
                        description: Const.aliveDescription
                    )
                case .life:
                    State.StateData.CellData(
                        image: Const.lifeImage,
                        icon: Const.lifeIcon,
                        title: Const.lifeTitle,
                        description: Const.lifeDescription
                    )
                }
            }
            self.updateState(.loaded(data: State.StateData(
                cells: cellsData,
                labelText: Const.labelText,
                buttonText: Const.buttonText
            )))
        }
    }

    private func updateState(_ newValue: State) {
        guard self.state != newValue else { return }
        self.state = newValue
    }
}
