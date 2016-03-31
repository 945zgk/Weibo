//
//  WBHomeMyCardViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/27.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit
import SDWebImage

class WBHomeMyCardViewController: UIViewController {

    @IBOutlet weak var lab_name: UILabel!
    @IBOutlet weak var imgv_card: UIImageView!
    @IBOutlet weak var imgv_avatar: UIImageView!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgv_card.image = createQRCodeImage()
        imgv_avatar.sd_setImageWithURL(NSURL(string: Defaults[.avatar_large]), placeholderImage: UIImage(named: "avatar_default"), options: .ContinueInBackground)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions 
    
    @IBAction func dismissSelf(sender: AnyObject) {
        
//        dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    // MARK: - Configure
    
    private func createQRCodeImage() -> UIImage {
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setDefaults()
        filter?.setValue("郑国凯".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        
        let output = filter?.outputImage
        let img = createNonInterpolatedUIImageFormCIImage(output!, size: 300)
        
        return img

    }
    
    /**
     合成图片
     
     :param: bgImage   背景图片
     :param: iconImage 头像
     */
    private func creteImage(bgImage: UIImage, iconImage: UIImage) -> UIImage
    {
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(bgImage.size)
        // 2.绘制背景图片
        bgImage.drawInRect(CGRect(origin: CGPointZero, size: bgImage.size))
        // 3.绘制头像
        let width:CGFloat = 50
        let height:CGFloat = width
        let x = (bgImage.size.width - width) * 0.5
        let y = (bgImage.size.height - height) * 0.5
        iconImage.drawInRect(CGRect(x: x, y: y, width: width, height: height))
        // 4.取出绘制号的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        // 6.返回合成号的图片
        return newImage
    }
    
    /**
     根据CIImage生成指定大小的高清UIImage
     
     :param: image 指定CIImage
     :param: size    指定大小
     :returns: 生成好的图片
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
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
