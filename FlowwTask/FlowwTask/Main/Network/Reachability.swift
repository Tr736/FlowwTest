import Foundation
import Network
import Combine
public final class ConcreteReachability {
    private enum Constants {
        static let queueName = "Monitor"
        static let notificationName = "ReachabilityChanged"
    }
    public static let shared = ConcreteReachability()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: Constants.queueName)

    @Published public var isReachable: Bool?

    init() {
        if AppContext.isOffline {
            configureOffline()
        } else {
            configureReachability()
        }
    }

    private func configureReachability() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }

    private func configureOffline() {
        self.isReachable = false
    }
}
