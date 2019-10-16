import UIKit

class XChangeViewController: UIViewController {
    @IBOutlet weak var mainCurrencyTextField: UITextField!
    @IBOutlet weak var currencyToBeChangeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension XChangeViewController: XChangeDelegate {
    func updateResult(with xChangeValue: XChangeModel) {
    }
    
    func onFail(error: String) {
        print(error)
    }
}

