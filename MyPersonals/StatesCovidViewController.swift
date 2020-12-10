
import UIKit

class StatesCovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // list of states api struct
    var covidDetailList: [StatesCovidDetail] = []
    
    let covidDetailRequest = CovidApiDetailRequest()
    
    
    @IBOutlet weak var statesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidDetailRequest.getCovidDetails { (states) in
            self.covidDetailList = states
            DispatchQueue.main.async {
                self.statesTableView.reloadData()
            }
        }
        statesTableView.delegate = self
        statesTableView.dataSource = self
    }
    
    // TABLE VIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.covidDetailList[indexPath.row].state
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCovidDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CovidDetailsViewController {
            destination.stateCovid = covidDetailList[(statesTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
}
