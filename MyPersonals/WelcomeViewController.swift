
import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            designLabels()
        // Do any additional setup after loading the view.
    }

    
    // design the labels
  func  designLabels(){
    welcomeLabel.layer.cornerRadius = 7
    welcomeLabel.layer.borderWidth = 3
    welcomeLabel.text = "WELCOME TO MYCOVID APP!"
    
    messageLabel.layer.cornerRadius = 10
    messageLabel.text = "Find the latest covid19 updates here, to get started, press the button below."
    
    getStartedButton.layer.cornerRadius = 10
    
    }
    
    
    

}

