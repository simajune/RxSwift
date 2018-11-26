//
//  ViewController.swift
//  Installingn RxSwift
//
//  Created by SIMA on 26/11/2018.
//  Copyright © 2018 SIMA. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = Observable.of("Hello RxSwift")
    }


}

