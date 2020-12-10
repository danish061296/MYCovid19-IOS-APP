
import UIKit
import Lottie

protocol CountrySelectionViewControllerDelegate: class {
    func getCountryName(_ countryName: String) 
}

class CountriesCovidViewController: UIViewController {
  
    weak var delegate: CountrySelectionViewControllerDelegate?
    
    @IBOutlet weak var countryNameTextField: UITextField!
    
    @IBOutlet weak var findDataButton: UIButton!
    let animationView = AnimationView()
    
    override func viewDidLoad() {
             super.viewDidLoad()
           findDataButton.layer.cornerRadius = 5
            setCovidAnimation()
        modifyTextField()
         }
    
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
//        countryNameTextField.resignFirstResponder()
        
        if countryNameTextField.text == nil{
            let alert = UIAlertController(title: "Error", message: "Please enter a country name!", preferredStyle: .alert)
                       
                               let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                       
                               alert.addAction(action)
                       
                               self.present(alert, animated: true)
                               return
        }
        if let countryNameValue = countryNameTextField.text {
            delegate?.getCountryName(countryNameValue)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please enter a country name!", preferredStyle: .alert)
            
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
                    alert.addAction(action)
            
                    self.present(alert, animated: true)
                    return
        }
    
    }
   
    // pops the keyboard as soon as text field is focused
    func modifyTextField() {
        countryNameTextField.becomeFirstResponder()
        countryNameTextField.returnKeyType = .done
        countryNameTextField.autocapitalizationType = .words
        countryNameTextField.autocorrectionType = .yes
    }
    
    // lottie animation
    func setCovidAnimation(){
        animationView.animation = Animation.named("Coronavirus")
        animationView.frame = CGRect(x: 0, y: 50, width: 250, height: 250)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
    }
   
}
