
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var countryNames: [String] = []
  var flags: [String] = []
  var totalCaseList: [Int] = []
  var totalDeathList: [Int] = []
  var totalRecoveredList: [Int] = []
  var dailyCaseList: [Int] = []
  var dailyDeathList: [Int] = []
  var dailyRecoveredList: [Int] = []
  
  var chosenCountryName = ""
  var chosenFlagUrl = ""
  var chosenTotalCases = ""
  var chosenTotalDeathts = ""
  var chosenTotalRecovered = ""
  var chosenDailyCases = ""
  var chosenDailyDeaths = ""
  var chosenDailyRecovered = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let addressUrl = URL(string: CovidAPI.address)
    
    let task = URLSession.shared.dataTask(with: addressUrl!) { (data, response, error) in
      guard let data = data else {
        print("Error1: \(error!)")
        return
      }
      let decoder = JSONDecoder()
      do {
        let country = try decoder.decode([CountryModel].self, from: data)
        
        for i in 0..<country.count {
          self.countryNames.append(country[i].country)
          self.flags.append(country[i].countryInfo.flag)
          self.totalCaseList.append(country[i].cases)
          self.totalDeathList.append(country[i].deaths)
          self.totalRecoveredList.append(country[i].recovered)
          self.dailyCaseList.append(country[i].todayCases)
          self.dailyDeathList.append(country[i].todayDeaths)
          self.dailyRecoveredList.append(country[i].todayRecovered)
          
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
        print(error)
      }
    }
    task.resume()
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countryNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = countryNames[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chosenCountryName = countryNames[indexPath.row]
    chosenFlagUrl = flags[indexPath.row]
    chosenTotalCases = "\(totalCaseList[indexPath.row])"
    chosenTotalDeathts = "\(totalDeathList[indexPath.row])"
    chosenTotalRecovered = "\(totalRecoveredList[indexPath.row])"
    chosenDailyCases = "\(dailyCaseList[indexPath.row])"
    chosenDailyDeaths = "\(dailyDeathList[indexPath.row])"
    chosenDailyRecovered = "\(dailyRecoveredList[indexPath.row])"
    performSegue(withIdentifier: "showCountryDetail", sender: self)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "showCountryDetail" else {
      print("List segue error")
      return
    }
    let countryVC = segue.destination as! CountryViewController
    countryVC.selectedCountryName = chosenCountryName
    countryVC.flagUrl = chosenFlagUrl
    countryVC.casesTotal = "\(chosenTotalCases)"
    countryVC.deathsTotal = "\(chosenTotalDeathts)"
    countryVC.recoveredTotal = "\(chosenTotalRecovered)"
    countryVC.casesDaily = "\(chosenDailyCases)"
    countryVC.deathsDaily = "\(chosenDailyDeaths)"
    countryVC.recoveredDaily = "\(chosenDailyRecovered)"
  }
}
