import UIKit

class XChangeViewController: UIViewController {
    @IBOutlet private weak var mainCurrencyTextField: UITextField!
    @IBOutlet private weak var currencyToBeChangeTextField: UITextField!
    @IBOutlet private weak var currencyButtonNameLabel: UILabel!
    @IBOutlet private weak var currencyButtonImageView: UIImageView!
    @IBOutlet private weak var textFieldCurrencyLabel: UILabel!
    
    private var viewModel: XChangeViewModel?
    
    private var toolBar = UIToolbar()
    private var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.viewModel = XChangeViewModel()
        self.bindViewModel(with: viewModel)
    }
    
    func bindViewModel(with viewModel: BaseViewModel?) {
        guard let viewModel = viewModel as? XChangeViewModel else { return }
        
    }
    
    
    @IBAction func onClickSelectCurrency(_ sender: UIButton) {
        pickerView = UIPickerView.init()
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 400)
        self.view.addSubview(pickerView)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
    
}

extension XChangeViewController: XChangeDelegate {
    func updateResult(with xChangeValue: XChangeModel) {
    }
    
    func onFail(error: String) {
        print(error)
    }
}

extension XChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let vModel = self.viewModel else { return 0 }
        return vModel.getItemsCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let vModel = self.viewModel else { return String.empty }
        return vModel.getEachItem(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let vModel = self.viewModel else { return }
        self.currencyButtonNameLabel.text = vModel.getEachItem(index: row)
        self.textFieldCurrencyLabel.text = vModel.getEachItem(index: row)
    }
}

