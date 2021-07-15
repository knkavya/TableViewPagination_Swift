//
//  Parser.swift
//  CustomTableView
//
//  Created by Kavya KN on 15/07/21.
//

import Foundation

// MARK: Requesting and getting data from api.
struct Parser {
    
    func parse(completionHandler : @escaping([Album])->() ) {
        
        let url = URL(string: "http://jsonplaceholder.typicode.com/photos")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Album].self, from: data)
                completionHandler(result)
            } catch let parseError {
                print("JSON Error \(parseError.localizedDescription)")
            }
        }
        task.resume()
    }
}
