import Combine
import SwiftUI

final class CreatorStore {
    // MARK: Internal

    enum State {
        case initial
        case loaded(data: [CellType])
    }

    enum CellType {
        case dead
        case alive
        case life
    }

    var statePublisher: AnyPublisher<State, Never> {
        self.stateSubject
            .eraseToAnyPublisher()
    }

    func createLive() {
        let randomValue = Int(arc4random_uniform(2))
        let newCell = randomValue == 1 ? CellType.alive : CellType.dead
        cells.append(newCell)

        checkLastCells()
        self.stateSubject.send(.loaded(data: cells))
    }

    func checkLastCells() {
        let lastThree = Array(cells.suffix(3))
        let isLastAlive = lastThree.allSatisfy { $0 == .alive }
        let isLastDead = lastThree.allSatisfy { $0 == .dead }

        if lastThree.count == 3, isLastAlive {
            cells.append(CellType.life)
        }

        if lastThree.count == 3, isLastDead {
            if let index = cells.lastIndex(where: { $0 == .life }) {
                cells.remove(at: index)
            }
        }
    }

    // MARK: Private

    private var stateSubject: CurrentValueSubject<State, Never> = .init(.loaded(data: []))
    private var cells = [CellType]()
}
