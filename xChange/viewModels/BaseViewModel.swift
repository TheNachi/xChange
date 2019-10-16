import Foundation
import EVReflection
import Alamofire

class BaseViewModel: ViewModelProtocol {
    var apiService: BaseApiService?
    var data: BaseModel?

    init() {
        self.apiService = nil
        self.data = nil
    }

    init(with data: BaseModel?, apiService: BaseApiService?) {
        self.apiService = apiService
        self.data = data
    }

    func deconstruct() {
        self.apiService?.cancelRequest()
    }
}

protocol ViewModelProtocol {
    var data: BaseModel? { get set }
    var apiService: BaseApiService? { get set }
    func deconstruct()
}

class BaseModel: EVObject {}
