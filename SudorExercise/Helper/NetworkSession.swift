//
//  NetworkSession.swift
//  SudorExercise
//

import Foundation

//Mark:-  An inteface to load table view with house name
protocol NetworkSessionDelegate {
    func loadTable()
}

class NetworkSession {
    
    //MARK:- Creates a shared instance for NetworkSession class
    static let sharedInstance = NetworkSession()
    var sessionDelegate: NetworkSessionDelegate? = nil
    
    let contant = Constants()
    let checkInternet = CheckInternet()
    let toast = Toast()
    
    var statusCode = 0
    var house: [House]?
    var houseNumber = 0
    var urlString = ""
    
    func fetchHouseFromAPI() {
        if houseNumber == 0 {
            urlString = contant.housesURL
        }
        else {
            urlString = "\(contant.housesURL)/\(String(describing: houseNumber))"
        }
        //MARK:- Create the url with NSURL
        let url = URL(string: urlString)!
        //MARK:- Create a Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if checkInternet.Connection() {
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                print("Loading URL")
                guard let data = data, error == nil else {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    self.statusCode = httpResponse.statusCode
                }
                
                do {
                    if self.statusCode == 200 {
                        self.house = try JSONDecoder().decode([House].self, from: data)
                        self.loadMessages(isSuccess: true)
                    }
                }
                catch {
                    print("Failed to parse JSON from URL")
                }
            })
            task.resume()
        }
        else {
            toast.displayToastMessage("No or poor internet connection")
        }
    }
    
    //MARK:- Populates the app UI with the saved messages
    func loadMessages(isSuccess: Bool) {
        DispatchQueue.main.async {
            if isSuccess {
                self.sessionDelegate?.loadTable()
            }
            else {
                self.toast.displayToastMessage("Something went wrong!")
            }
        }
    }
}
