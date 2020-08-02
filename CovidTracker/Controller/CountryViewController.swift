
import UIKit

class CountryViewController: UIViewController {
  
  @IBOutlet weak var flagImage: UIImageView!
  @IBOutlet weak var countryName: UILabel!
  
  @IBOutlet weak var dailyConfirmed: UILabel!
  @IBOutlet weak var dailyDeaths: UILabel!
  @IBOutlet weak var dailyRecovered: UILabel!
  
  @IBOutlet weak var totalConfirmed: UILabel!
  @IBOutlet weak var totalDeaths: UILabel!
  @IBOutlet weak var totalRecovered: UILabel!
  
  var selectedCountryName = ""
  var flagUrl = ""
  var casesTotal = ""
  var deathsTotal = ""
  var recoveredTotal = ""
  var casesDaily = ""
  var deathsDaily = ""
  var recoveredDaily = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    countryName.text = selectedCountryName
    totalConfirmed.text = casesTotal
    totalDeaths.text = deathsTotal
    totalRecovered.text = recoveredTotal
    dailyConfirmed.text = casesDaily
    dailyDeaths.text = deathsDaily
    dailyRecovered.text = recoveredDaily
    
    guard let flagUrl = URL(string: flagUrl) else {
      print("Flag Error")
      return
    }
    
    let task = URLSession.shared.dataTask(with: flagUrl) { (data, response, error) in
      if let data = data {
        let downloadedImage = UIImage(data: data)
        DispatchQueue.main.async {
          self.flagImage.image = downloadedImage
        }
      }
    }
    task.resume()
  }
}
