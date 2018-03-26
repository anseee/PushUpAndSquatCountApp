//
//  ViewController.swift
//  PushUpCount
//
//  Created by 박성원 on 2018. 3. 26..
//  Copyright © 2018년 pushup. All rights reserved.
//

import UIKit

enum WorkoutMode {
    case PUSH_UP
    case SQUAT
}

class ViewController: UIViewController {

    var pushUpInfo = [String:String]()
    var squatInfo = [String:String]()
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var todayCount: UILabel!
    
    var currentModel: WorkoutMode = .PUSH_UP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSensor()
    }

    func addSensor() {
        UIDevice.current.isProximityMonitoringEnabled = true
        if UIDevice.current.isProximityMonitoringEnabled {
            count.text = "0"
            NotificationCenter.default.addObserver(self, selector: #selector(didChangePushUpCount), name: .UIDeviceProximityStateDidChange, object: nil)

        }
        else {
            count.text = "Proximity 센서를 사용할 수 없습니다."
        }
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        UIDevice.current.isProximityMonitoringEnabled = false
        
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        if currentModel == .PUSH_UP {
            UIDevice.current.isProximityMonitoringEnabled = true
        }
    }
    
    @IBAction func modeChange(_ sender: UIButton) {
        let pushup = 0
        let squat = 1
        
        if sender.tag == pushup {
            currentModel = .PUSH_UP
            UIDevice.current.isProximityMonitoringEnabled = true
        }
        else if sender.tag == squat {
            currentModel = .SQUAT
            UIDevice.current.isProximityMonitoringEnabled = false
        }
    }
    
    @objc func didChangePushUpCount() {
        if UIDevice.current.proximityState {
            if let currentCount = Int(count.text!) {
                count.text = "\(currentCount + 1)"
                totalCount.text = "합계: \(currentCount + 1)"
                todayCount.text = "오늘: \(currentCount + 1)"
            }
        }
    }
}

