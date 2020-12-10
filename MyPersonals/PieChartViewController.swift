
import UIKit
import Charts

class PieChartViewController: UIViewController, CountrySelectionViewControllerDelegate {
    
    @IBOutlet weak var countryNameButton: UIButton!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var covidPieChart: PieChartView!
    
    
    @IBOutlet weak var confirmedCasesLabel: UILabel!
    
    @IBOutlet weak var recoveredCasesLabel: UILabel!
    
    
    var newCountryName: String? = nil {
        didSet {
            if let newCountry = newCountryName {
                countryNameLabel.text =  newCountry
            } else {
                countryNameLabel.text = " "
            }
            
        }
    }
    
    var confirmedCases: String? = nil {
        didSet {
            if let newCase = confirmedCases {
                confirmedCasesLabel.text = "Cases: " + newCase
            } else {
                confirmedCasesLabel.text = " "
            }
            
        }
    }
    
    var recoveredCases: String? = nil {
        didSet {
            if let newRecover = recoveredCases {
                recoveredCasesLabel.text = "Recover: " + newRecover
            } else {
                recoveredCasesLabel.text = " "
            }
            
        }
    }
    
    
    var currentCountryName: String = ""
    var casesConfirmed: Double = 0.0
    var casesRecovered: Double = 0.0
    
    
    var pieChartModel = PieChartModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPieChart()
        covidPieChart.chartDescription?.text = "Covid19 Pie Chart"
        covidPieChart.chartDescription?.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)!
        countryNameButton.layer.cornerRadius = 5
        countryNameButton.layer.cornerRadius = 5
        updateCounryLabel()
        self.covidPieChart.reloadInputViews()
        self.stylePieChartData()

        designLabel()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let countrySelectionVC = segue.destination as? CountriesCovidViewController {
            countrySelectionVC.delegate = self
        }
    }
    
    
    // presenting and updating pie chart to the main view
      var CovidDetailResponse:CovidDetail?
      {
          didSet {
              DispatchQueue.main.async {
                  self.covidPieChart.reloadInputViews()
                  self.stylePieChartData()
                  self.presentCovidPieChartValue()
              }
          }
      }
    
    // initialize the pie chart with dummy values
    func initPieChart(){
        let confirmedCases: PieChartDataEntry = pieChartModel.covidConfirmedCases
        confirmedCases.value = 342334
        let recoveredCases: PieChartDataEntry =  pieChartModel.covidRecoveredCases
        recoveredCases.value = 423533
    }
    
    // present chart value after getting data from the API
    func presentCovidPieChartValue (){
        
        let confirmedCases: PieChartDataEntry = pieChartModel.covidConfirmedCases
                    
        print("cases confirmed hehe \(Double(casesConfirmed))")
        confirmedCases.label = "Confirmed Cases"
        confirmedCases.value = casesConfirmed
        
        let recoveredCases: PieChartDataEntry =  pieChartModel.covidRecoveredCases
        recoveredCases.value = casesRecovered
        print("cases recovered hehe \(Double(casesRecovered))")
        
        recoveredCases.label = "Recovered Cases"
        pieChartModel.covidCasesDataArray  = [confirmedCases,recoveredCases]
        stylePieChartData()
    }
    
    // style the font and heading of pie chart
    func stylePieChartData(){
        let pieChartDataSet = PieChartDataSet(entries: pieChartModel.covidCasesDataArray, label: nil)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueTextColor(.black)
        let pieChartColors = [UIColor(named: "casesConfirmed"), UIColor(named: "casesRecovered")]
        pieChartDataSet.colors = pieChartColors as! [NSUIColor]
        covidPieChart.data = pieChartData

        
    }
    
    func designLabel(){
        
        countryNameLabel.layer.borderWidth = 5.0
        countryNameLabel.layer.cornerRadius = 5
        countryNameLabel.layer.masksToBounds = true
        
        confirmedCasesLabel.layer.borderWidth = 3.0
        confirmedCasesLabel.layer.cornerRadius = 5
        confirmedCasesLabel.layer.masksToBounds = true
        
        recoveredCasesLabel.layer.borderWidth = 3.0
        recoveredCasesLabel.layer.cornerRadius = 5
        recoveredCasesLabel.layer.masksToBounds = true
    }
    
    func updateCounryLabel(){
        
        countryNameLabel.text = "\(currentCountryName)"
        
        confirmedCasesLabel.text = "Confirmed: \(Double(casesConfirmed))"
        recoveredCasesLabel.text = "Recovered: \(Double(casesRecovered))"
        
    }
    
    
    // pass the country name to get its covid details
    func getCountryName(_ countryName: String){
        if countryName.isEmpty  {
            // if empty show an alert
            let alert = UIAlertController(title: "Error", message: "Country name must be provided!", preferredStyle: .alert)

            let action = UIAlertAction(title: "OK", style: .default, handler: nil)

            alert.addAction(action)

            self.present(alert, animated: true)
            
            return ;
        }
        
        // otherwise get the data about the country
        let covidRequest = CovidApiRequest(countryName: countryName)
        
        covidRequest.getCountryNameFromUrl { [weak self] result in
            switch result {
                
            // if error getting data from the API
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Error", message: "Please enter a valid country name!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self?.present(alert, animated: true)
                
                
            // if the API request is successful
            case .success(let covidDetails):
                self?.CovidDetailResponse = covidDetails
                print(covidDetails)
                self?.casesConfirmed = Double(covidDetails.cases)
                self?.casesRecovered = Double(covidDetails.recovered)
                
                DispatchQueue.main.async {
                    self?.updateCounryLabel()
                    self?.countryNameLabel.text = "\(countryName)"

                }
            }
        }
        
    }
    
}
