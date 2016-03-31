//
//  HomeViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit
import Alamofire

class WBHomeViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    private struct AssociatedObject {
        static var WBHomeViewCell = "WBHomeViewCell"
    }
    
    /// 保存转场对象。否则不会出现自定义转场效果
    private lazy var popover_animator = WBHomePopoverAnimator()
    private lazy var list_statuses = [Statuses]()
    // MARK: -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WBHomeViewController.changeTitleView), name: WBPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WBHomeViewController.changeTitleView), name: WBPopoverAnimatorWillDismiss, object: nil)
        self.tableView.estimatedRowHeight = 400
        
        fetchStatuses()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc private func share() {
        
    }
    
    @objc private func comment() {
        
    }
    
    @objc private func praise() {
        
    }
    
    @objc private func changeTitleView() {
        
        if let btn_title = navigationItem.titleView as? UIButton {
            btn_title.selected = !btn_title.selected
        }
        
    }
    
    @objc private func clickLeftItem() {
        
    }
    
    @objc private func clickRightItem() {
        
         let controller = UIStoryboard(name: "WBHome", bundle: nil).instantiateViewControllerWithIdentifier("WBHomeQRCodeViewController") as! WBHomeQRCodeViewController
//        let controller = UIStoryboard(name: "WBHome", bundle: nil).instantiateViewControllerWithIdentifier("WBHomeQRCodeNavController")
        
//        presentViewController(controller, animated: true, completion: nil)
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    @objc private func clickTitleView(btn: UIButton) {
        
        if let controller = UIStoryboard(name: "WBHome", bundle: nil).instantiateViewControllerWithIdentifier("WBHomePopoverViewController") as? WBHomePopoverViewController {
            
            // modal: 默认会先移除旧视图，再添加新视图
            controller.transitioningDelegate = popover_animator
            controller.modalPresentationStyle = .Custom
            
            presentViewController(controller, animated: true, completion: nil)
            
        }
        
    }
    
    // MARK: - Configure
  
    private func configureNavBar() {

        let btn_title = WBTitleButton()
    
        btn_title.addTarget(self, action: #selector(WBHomeViewController.clickTitleView(_:)), forControlEvents: .TouchUpInside)
        
        navigationItem.titleView = btn_title
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: #selector(WBHomeViewController.clickLeftItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: #selector(WBHomeViewController.clickRightItem))
        
    }
    
    // 布局图片
    private func drawImgInCell(indexPath: NSIndexPath, cell: UITableViewCell) {
        
        let view = cell.contentView.viewWithTag(10)
        
        if view == nil {
            return
        }
        
        for subview in view!.subviews {
            subview.removeFromSuperview()
        }
        
        let lst_imgUrl = []
        
//        if lst_imgUrl == nil || lst_imgUrl.count < 1 {
//            return
//        }
        
        if lst_imgUrl.count == 1 {
            
            let width = (SCREEN_WIDTH - 20 * 2 - 78.0) * 2.0 / 3.0
            let height = width * 14.0 / 23.0
            
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            
            imgView.contentMode = .ScaleAspectFill
            imgView.clipsToBounds = true
            
            if let imgUrl = lst_imgUrl[0] as? String {
                
                imgView.image = UIImage()
            }
            
            view!.addSubview(imgView)
            
        } else {
            
            for (index, object) in EnumerateSequence(lst_imgUrl) {
                
                if index > 2 {
                    break
                }
                
                if let imgUrl = object as? String {
                    
                    let x = CGFloat(index % 3)
                    let y = CGFloat(index / 3)
                    let width = (SCREEN_WIDTH - 20.0 * 2 - 78.0 - 16.0) / 3.0
                    let marginX = CGFloat(0.0)
                    let seperateOfImg = CGFloat(8)
                    
                    let imgView = UIImageView(frame: CGRect(x: marginX + (width + seperateOfImg) * x, y: (width + seperateOfImg) * y, width: width, height: width))
                    
                    imgView.contentMode = .ScaleAspectFill
                    imgView.clipsToBounds = true
                    
                    imgView.image = UIImage()
                    
                    view!.addSubview(imgView)
                }
            }
        }
    }
    
    // MARK: - Fetch
    
    private func fetchStatuses() {
        
//        let params = ["access_token" : Defaults[.access_token], "count": 1]
        let params = ["access_token" : Defaults[.access_token]]

//         as! [String : AnyObject]
        Alamofire.request(.GET, "\(WB_API)/2/statuses/home_timeline.json", parameters: params).responseJSON { [weak self] response in
            
            guard self != nil else { return }
            
            switch response.result {
            case .Success:
                
                if let JSON = response.result.value {
                    
                    print(JSON)
                    
                    if let _ = JSON["error"] as? String {
                        print("error--fetchStatuses--\(JSON)")
                    }
                    
                    if let statuses = JSON["statuses"] as? [[String: AnyObject]] {
                        
                        for dict in statuses {
                            self!.list_statuses.append(Statuses(dict: dict))
                        }
                        
                        self!.tableView.reloadData()
                        
                    }
                    
                }
                
            case .Failure:
                tips.showTipsInMainThread(Text: "服务器访问有误")
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list_statuses.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let statuses = list_statuses[indexPath.row]
//        let user = statuses.user
        
        lab_caculate.text = statuses.text
        
        return 400
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WBHomeViewCell", forIndexPath: indexPath)
        let statuses = list_statuses[indexPath.row]
        let user = statuses.user
        
        if let imgv_avatar = cell.viewWithTag(12) as? UIImageView {
            imgv_avatar.sd_setImageWithURL(NSURL(string: user.avatar_large), placeholderImage: UIImage(named: "avatar_default"), options: .ContinueInBackground)
        }
        
        if let imgv_verified = cell.viewWithTag(13) as? UIImageView,
            verified_type = user.verified_type {
            
            switch "\(verified_type)" {
            case "0":
                imgv_verified.image = UIImage(named: "avatar_vip")
            case "2", "3", "5":
                imgv_verified.image = UIImage(named: "avatar_enterprise_vip")
            case "220":
                imgv_verified.image = UIImage(named: "avatar_grassroot")
            default:
                imgv_verified.image = nil
            }
        }
        
        if let imgv_vip = cell.viewWithTag(15)as? UIImageView {
            if user.screen_name == "稀土圈" || user.name == "稀土圈" {
                print("------------------")
            }
            if user.mbrank > 0 && user.mbrank < 7 {
                imgv_vip.image = UIImage(named: "common_icon_membership_level\(user.mbrank)")
            } else {
                imgv_vip.image = nil
            }
            
        }
        
        if let lab_name = cell.viewWithTag(14) as? UILabel {
            lab_name.text = user.screen_name
        }
        
        if let lab_created_at = cell.viewWithTag(16) as? UILabel {
            lab_created_at.text = user.created_at
        }
        
        if let lab_source = cell.viewWithTag(17) as? UILabel {
            lab_source.text = statuses.source
        }
        
        if let lab_text = cell.viewWithTag(21) as? UILabel {
            lab_text.text = statuses.text
        }
        
        if let btn_share = cell.viewWithTag(41) as? UIButton {
            
            btn_share.addTarget(self, action: #selector(WBHomeViewController.share), forControlEvents: .TouchUpInside)
            objc_setAssociatedObject(btn_share, &AssociatedObject.WBHomeViewCell, cell, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if statuses.reposts_count == 0 {
                btn_share.setTitle("转发", forState: .Normal)
            } else {
                btn_share.setTitle("\(statuses.comments_count)", forState: .Normal)
            }
        }
        
        if let btn_comment = cell.viewWithTag(42) as? UIButton {
            
            btn_comment.addTarget(self, action: #selector(WBHomeViewController.comment), forControlEvents: .TouchUpInside)
            objc_setAssociatedObject(btn_comment, &AssociatedObject.WBHomeViewCell, cell, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if statuses.comments_count == 0 {
                btn_comment.setTitle("评论", forState: .Normal)
            } else {
                btn_comment.setTitle("\(statuses.comments_count)", forState: .Normal)
            }
            
        }
        
        if let btn_praise = cell.viewWithTag(43) as? UIButton {
            
            btn_praise.addTarget(self, action: #selector(WBHomeViewController.praise), forControlEvents: .TouchUpInside)
            objc_setAssociatedObject(btn_praise, &AssociatedObject.WBHomeViewCell, cell, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if statuses.attitudes_count == 0 {
                btn_praise.setTitle("赞", forState: .Normal)
            } else {
                btn_praise.setTitle("\(statuses.attitudes_count)", forState: .Normal)
            }
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 0, height: 0)
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return list_statuses[]
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WBHomeClvCell", forIndexPath: indexPath)
        
        if let img = cell.viewWithTag(11) as? UIImageView {
           
            img.image = UIImage(named: "")
            
        }
        
        return cell
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
