import Foundation
import Alamofire

class XChangeApi: BaseApiService {
    private let BASEURL: String = Constants.baseURL
    
    func getXChangeRates(xChangeDelegate: XChangeDelegate) {
        let url = "\(BASEURL)latest"
        let parameter: Parameters = ["access_key":Constants.token,
                                      "symbols": "aed"]
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameter)
        request.responseString { (responseData) in
            self.delegate = xChangeDelegate
            self.processResponse(response: responseData, complete: { (responseString) in
                let xChangeData = XChangeModel(json: responseString)
                xChangeDelegate.updateResult(with: xChangeData)
            })
        }
        self.handleRequest(dataRequest: request)
    }
}

protocol XChangeDelegate: DataDelegate {
    func updateResult(with xChangeValue: XChangeModel)
}
