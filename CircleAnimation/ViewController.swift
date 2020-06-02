//
//  ViewController.swift
//  CircleAnimation
//
//  Created by Yuki Shinohara on 2020/06/01.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    
    let shapeLayer = CAShapeLayer()
    
    private var timer = Timer()
    
    private var count:Float = 10
       {
           didSet{
               timerLabel.text = String(count)
               if count < 0{
                   count = 0
               }
           }
           
       }
//
//    var prevCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "たいまー"
        view.backgroundColor = UIColor(red: 245/255, green: 255/255, blue: 250/255, alpha: 1)
        timerLabel.text = String(count)
        timerLabel.font = UIFont.systemFont(ofSize: view.frame.width/14)
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: view.frame.height/10))
//        label.center = self.view.center
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 39)
//        label.text = String(count)
//        self.view.addSubview(label)
        
        
        let center = view.center
        
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.width/3, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi * 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = view.frame.width/14
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = view.frame.width/14
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
//        view.layer.addSublayer(label)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap(){
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .default)
            
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 1
//            basicAnimation.duration = CFTimeInterval(count)
            
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
            
            shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        }
        
    }
    
    @objc private func updateTimer() {
        if count > 0{
            count -= 1
            timerLabel.text = String(count)
        }
        
        if count == 0{
            timer.invalidate()
//            timerLabel.text = String(prevCount)
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let ac = UIAlertController(title: "タイマーをセット", message: nil, preferredStyle: .alert)
                
                ac.addTextField { (textField) in
                    textField.placeholder = "Seconds here"
                    textField.keyboardType = .numberPad
                }
                let add = UIAlertAction(title: "追加", style: .default) { (void) in
                    let textField = ac.textFields![0] as UITextField //ワンクッション
                    if let text = textField.text{
                        self.count = Float(text) ?? 10
//                        self.prevCount = Int(text) ?? 10
                    }
                }
                let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
                ac.addAction(add)
                ac.addAction(cancel)
                present(ac, animated: true)
    }
}

