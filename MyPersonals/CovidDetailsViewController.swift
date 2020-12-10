
import UIKit
import Lottie

class CovidDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var casesLabel: UILabel!
    
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var deathsLabel: UILabel!
    
    var stateCovid:StatesCovidDetail?
    
    
    
    var stateName: String? = nil {
        didSet {
            if let newState = stateName {
                stateLabel.text = newState
            } else {
                stateLabel.text = ""
            }
            
        }
    }
    var stateCases: String? = nil {
        didSet {
            if let newCase = stateCases {
                casesLabel.text = newCase
            } else {
                casesLabel.text = ""
            }
            
        }
    }
    
    var stateActive: String? = nil {
        didSet {
            if let newActive = stateActive {
                activeLabel.text = newActive
            } else {
                activeLabel.text = ""
            }
            
        }
    }
    
    var stateDeaths: String? = nil {
        didSet {
            if let newDeath = stateDeaths {
                deathsLabel.text = newDeath
            } else {
                deathsLabel.text = ""
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCovidLabels()
        setStayHomeAnimation()
        designLabels()
    }
    
    func updateCovidLabels(){
        stateLabel.text = stateCovid?.state
        casesLabel.text = "Cases: \((stateCovid?.totalTestResults)!)"
        activeLabel.text = "Active: \((stateCovid?.positive)!)"
        deathsLabel.text = "Deaths: \((stateCovid?.death)!)"
    }
    
    func designLabels(){
        stateLabel.layer.borderWidth = 3.0
        stateLabel.layer.cornerRadius = 5
        stateLabel.layer.masksToBounds = true
        
        casesLabel.layer.borderWidth = 3.0
        casesLabel.layer.cornerRadius = 5
        casesLabel.layer.masksToBounds = true
        
        activeLabel.layer.borderWidth = 3.0
        activeLabel.layer.cornerRadius = 5
        activeLabel.layer.masksToBounds = true
        
        deathsLabel.layer.borderWidth = 3.0
        deathsLabel.layer.cornerRadius = 5
        deathsLabel.layer.masksToBounds = true
    }
    
    let animationView = AnimationView()
    
    // show Lottie animation
    func setStayHomeAnimation(){
        animationView.animation = Animation.named("StayHome")
        animationView.frame = CGRect(x: 75, y: 400, width: 250, height: 250)
        //        animationView.center = view.
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        
    }
    
}
