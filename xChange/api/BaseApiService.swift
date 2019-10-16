import Foundation
import Alamofire

class BaseApiService {
    weak var delegate: DataDelegate?
    private var requests: [DataRequest] = []
    
    convenience init() {
        self.init(with: nil)
    }
    
    init(with delegate: DataDelegate?) {
        self.delegate = delegate
    }
    
    @discardableResult
    func handleRequest(dataRequest: DataRequest?) -> Bool {
        guard let request = dataRequest else {
            return false
        }
        self.requests.append(request)
        return true
    }

    func cancelRequest() {
        self.delegate = nil
        self.requests.forEach { (request) in
            request.cancel()
        }
        self.requests.removeAll()
    }

    func processResponse(response: DataResponse<String>, complete: (String) -> Void) {
        if response.response?.statusCode == 200 {
            guard let data = response.result.value else {
                self.delegate?.onFail(error: BaseErrorResponse.networkError)
                return
            }
            complete(data)
        } else {
            guard let failMessage = response.value else {
                DispatchQueue.main.async {
                    self.delegate?.onFail(error: BaseErrorResponse.serverError)
                }
                return
            }
            let error = BaseErrorResponse(json: failMessage)
            DispatchQueue.main.async {
                self.delegate?.onFail(error: error.errorMessage)
            }
        }
    }
}

protocol DataDelegate: class {
    func onFail(error: String)
}

class BaseErrorResponse: BaseModel {
    var message: String = "Response is null"
    var code: String = "UNKNOWN_REASON"
    var statusCode: String = "500"
    var err: String = "Default Message"
    var errorMessage: String = "Default Message"

    static let serverError: String = "Our server has a problem understanding what just happened. Please retry."
    static let networkError: String = "Network error! Please try again."
}

