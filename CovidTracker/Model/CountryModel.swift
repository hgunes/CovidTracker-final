
struct CountryModel: Codable {
  let country: String
  let cases: Int
  let todayCases: Int
  let deaths: Int
  let todayDeaths: Int
  let recovered: Int
  let todayRecovered: Int
  let countryInfo: CountryInfo
}

struct CountryInfo: Codable {
  let flag: String
}
