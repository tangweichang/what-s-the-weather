//
//  ViewController.swift
//  Whats The Weather
//
//  Created by TangWeichang on 8/8/15.
//  Copyright © 2015 TangWeichang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
            
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray!.count > 1 {
                    //print(websiteArray![1])
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    //print(weatherArray[0])
                    if weatherArray.count > 1 {
                        wasSuccessful = true
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") // º is alt + 0
                        // Updating the result label
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.result.text = weatherSummary
                        })
                        
                    }
                    
                    
                }
            
            
            }
            if wasSuccessful == false {
                self.result.text = "Couldn't find the weather for that city - please try again."
            }
        }
        task?.resume()
        } else {
            self.result.text = "Couldn't find the weather for that city - please try again."
        }
    }
    
    
    
    @IBOutlet var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

