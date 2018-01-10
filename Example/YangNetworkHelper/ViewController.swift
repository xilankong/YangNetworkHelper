//
//  ViewController.swift
//  YangNetworkHelper
//
//  Created by xilankong on 01/09/2018.
//  Copyright (c) 2018 xilankong. All rights reserved.
//

import UIKit
import YangNetworkHelper

class ViewController: UIViewController, APICallBackDelegate {

  
    var btn = UIButton(type: UIButtonType.custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.setTitle("测试", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(doRequest), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func doRequest(){
        
        let api = ViewClientAPI()
        api.delegate = self
        api.start { (resp, error) in
            print(resp,"-------")
        }
        //        api.cancle()
    }
    
    
    public func api(_ api: BaseAPI!, success responseObject: Any!) {
        
        print(responseObject,"-------")
        
    }
    
    public func api(_ api: BaseAPI!, failue error: ReqCallBackCode!) {
        print(error,"-------")
    }

}

