//
//  ConnectionHelper.swift
//  SG Mobile Network
//
//  Created by Howie Siow on 13/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import UIKit

class ConnectionHelper: NSObject {
    
    func GETapiCall(url: String, completion: (String) -> ()) -> String{
        var result = ""
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        //var request = NSURLRequest(url: url)
        request.url = NSURL(string: url) as URL?
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if(error == nil){
                print(String(data: data!, encoding: .utf8)!)
                result = String(data: data!, encoding: .utf8)!
            }
            else{
                //print(error!)
                result = error!.localizedDescription
            }
            //completion(result)
        })
        task.resume()
        
        
        return result
    }
    
    func completeLoadAction(urlString:String, completion: @escaping(String,Bool) -> ()) -> (String, Bool){
       let url = URL(string:urlString.trimmingCharacters(in: .whitespaces))
       let request = URLRequest(url: url!)
        var result = ""
        var isSuccess = false
        
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data, error == nil else {
             DispatchQueue.main.async {
                //let alert = UIAlertController(title: "Message", message: error?.localizedDescription, preferredStyle: .alert)
                       
                //alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                completion(error!.localizedDescription,isSuccess)

            }
             return
          }

          let responseString = String(data: data, encoding: .utf8)
          DispatchQueue.main.async {
            //let alert = UIAlertController(title: "Message", message: String(data: data, encoding: .utf8)!, preferredStyle: .alert)
                    
            //alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            isSuccess = true
            completion(String(data: data, encoding: .utf8)!,isSuccess)
          }
        
        if(responseString == nil || responseString == ""){
            result = error!.localizedDescription
            
        }else{
            result = responseString!
            isSuccess = true
        }
       }
       task.resume()
        
        return (result,isSuccess)

    }
}
