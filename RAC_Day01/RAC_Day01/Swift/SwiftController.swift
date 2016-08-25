//
//  SwiftController.swift
//  RAC_Day01
//
//  Created by huangbaoyu on 16/8/25.
//  Copyright © 2016年 chachong. All rights reserved.
//

import UIKit

class SwiftController: UIViewController {

    @IBOutlet weak var username: UITextField!
 
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = "asd"
        let usernameSignal = username.rac_textSignal()
            .map { (value) -> AnyObject! in
                let text = value as!String
                if text.characters.count>3
                {
                    return true
                }else
                {
                    return false
                }
                
             
            }

        
        let passwordSignal = password.rac_textSignal()
            .map { (value) -> AnyObject! in
                let text = value as!String
                if text.characters.count>3
                {
                    return true
                }else
                {
                    return false
                }
                
        }
        
        
       
//
//
//        let loginSignal = RACSignal.combineLatest([usernameSignal,passwordSignal])
//            .reduceEach { (usernameValid,passwordValid) -> AnyObject! in
//                return true
//        }
//        
       

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
