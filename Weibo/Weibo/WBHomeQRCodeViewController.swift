
//
//  WBHomeQRCodeViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit
import AVFoundation

class WBHomeQRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    private lazy var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    private lazy var output = AVCaptureMetadataOutput()
    private lazy var session = AVCaptureSession()
    private lazy var layer_draw: CALayer = CALayer()
    private lazy var input: AVCaptureDeviceInput? = {
        do {
            let input = try AVCaptureDeviceInput(device: self.device)
            return input
        } catch {
            print(error)
            return nil
        }
    }()
    private lazy var layer_preview: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    @IBOutlet weak var lab_result: UILabel!
    @IBOutlet weak var imgv_scan: UIImageView!
    /// 扫描容器高度约束
    @IBOutlet weak var cons_container_height: NSLayoutConstraint!
    /// 冲击波视图顶部约束
    @IBOutlet weak var cons_scan_line: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.cons_scan_line.constant = -self.cons_container_height.constant
//        self.imgv_scan.layoutIfNeeded()
//        
//        UIView.animateWithDuration(2.5, animations: {
//            
//            self.cons_scan_line.constant = self.cons_container_height.constant
//            UIView.setAnimationRepeatCount(MAXFLOAT)
//            self.imgv_scan.layoutIfNeeded()
//            
//        })
        //
        startScan()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        UIView.setAnimationRepeatCount(MAXFLOAT)
//            self.cons_scan_line.constant = -self.cons_container_height.constant
//            self.imgv_scan.layoutIfNeeded()
//            
//            UIView.animateWithDuration(2.5, animations: {
//                
//                self.cons_scan_line.constant = self.cons_container_height.constant
//                self.imgv_scan.layoutIfNeeded()
//                
//        })
        
    }
    
    // MARK: - Actions
    
    @IBAction func gotoMyCode(sender: UIButton) {
        
        if let controller = UIStoryboard(name: "WBHome", bundle: nil).instantiateViewControllerWithIdentifier("WBHomeMyCardViewController") as? WBHomeMyCardViewController {
            navigationController?.pushViewController(controller, animated: false)
        }
        
    }
    
    /// 清空边线
    private func clearConers() {
        
        if layer_draw.sublayers == nil || layer_draw.sublayers?.count == 0 {
            return
        }
        
        for sub in layer_draw.sublayers! {
            sub.removeFromSuperlayer()
        }
        
    }
    
    private func drawCorners(code: AVMetadataMachineReadableCodeObject) {
        
        if code.corners.isEmpty {
            return
        }
        
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        var point = CGPointZero
        var index: Int = 0
        
        layer.lineWidth = 4
        layer.strokeColor = UIColor.darkGrayColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        CGPointMakeWithDictionaryRepresentation((code.corners[index] as! CFDictionary), &point)
        index += 1
        path.moveToPoint(point)
        
        while index < code.corners.count {
            
            CGPointMakeWithDictionaryRepresentation((code.corners[index] as! CFDictionary), &point)
            path.addLineToPoint(point)
            index += 1
            
        }
        
        path.closePath()
        
        layer.path = path.CGPath
        
        layer_draw.addSublayer(layer)
        
    }
    
    @IBAction func dismissSelf(sender: AnyObject) {
        
//        dismissViewControllerAnimated(true, completion: nil)
    navigationController?.popViewControllerAnimated(true)
        
    }
    
    private func startScan() {
        
        if !session.canAddInput(input) || !session.canAddOutput(output) {
            return
        }
        
        session.sessionPreset = AVCaptureSessionPreset1920x1080
        session.addInput(input)
        session.addOutput(output)
        
        // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        layer_preview.frame = SCREEN_BOUNDS
        layer_draw.frame = SCREEN_BOUNDS
        
        view.layer.insertSublayer(layer_preview, atIndex: 0)
        layer_preview.addSublayer(layer_draw)
        
        session.startRunning()
        
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
//        session.stopRunning()
        
        clearConers()
        
        if metadataObjects.first?.type == AVMetadataObjectTypeQRCode {
            lab_result.text = metadataObjects.first?.stringValue
            lab_result.sizeToFit()
        }
        
        for obj in metadataObjects {
            
            // 可以识别
            if obj is AVMetadataMachineReadableCodeObject {
                
                let code = layer_preview.transformedMetadataObjectForMetadataObject(obj as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                drawCorners(code)
            }
            
        }
        
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
