//swiftlint:disable identifier_name
import Foundation

class XChangeModel: BaseModel {
    var success: Bool = true
    var timestamp: Int = 0
    var base: String = String.empty
    var date: String = String.empty
    var rates: NSDictionary = NSDictionary()
}
