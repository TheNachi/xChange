import Foundation

class XChangeViewModel: BaseViewModel {
    private var items = ["this", "that", "which", "just", "gone"]
}

extension XChangeViewModel: XChangeVMProtocol {
    func getEachItem(index: Int) -> String {
        return self.getItems()[index]
    }
    
    func getItemsCount() -> Int {
        return self.getItems().count
    }
    
    func getItems() -> [String] {
        return self.items
    }
}

protocol XChangeVMProtocol {
    func getItems() -> [String]
    func getItemsCount() -> Int
    func getEachItem(index: Int) -> String
}
