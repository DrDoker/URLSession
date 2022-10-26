import UIKit
import CryptoKit

// MARK: - Задание

let currenciesURL = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json"

func getData(urlReuaest: String) {
    let urlReuaest = URL(string: urlReuaest)
    guard let url = urlReuaest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            let errorString = error?.localizedDescription ?? ""
            print("Error: \(errorString)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            guard let dataAsString = String(data: data, encoding: .utf8) else { return }
            print("Server response code: \(response.statusCode)")
            print("Data from the server: \(dataAsString)")
        } else if let response = response as? HTTPURLResponse {
            print("Server response code: \(response.statusCode)")
        }
    }.resume()
}

getData(urlReuaest: currenciesURL)

// MARK: - Задание⭐
func md5Hash(_ source: String) -> String {
    return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
}

let marvelPrivateKey = "2895055c5371280d7387073cc3ef477e45632869"
let marvelPublicKey = "d8182c561967ebc637775965e3484849"

let ts = "Serhii-Tkachenko"
let hashString = ts + marvelPrivateKey + marvelPublicKey
let hashMD5 = md5Hash(hashString)

let searchItem = "Loki"

var urlComponents = URLComponents()
urlComponents.scheme = "https"
urlComponents.host = "gateway.marvel.com"
urlComponents.path = "/v1/public/characters"
urlComponents.queryItems = [
   URLQueryItem(name: "name", value: searchItem),
   URLQueryItem(name: "ts", value: ts),
   URLQueryItem(name: "apikey", value: marvelPublicKey),
   URLQueryItem(name: "hash", value: hashMD5)
]

let urlString = urlComponents.url?.absoluteString ?? ""
getData(urlReuaest: urlString)
