//
//  HomeViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBHomeViewController: UITableViewController {
    
    /// 保存转场对象。否则不会出现自定义转场效果
    private lazy var popover_animator = WBHomePopoverAnimator()
    
    // MARK: -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WBHomeViewController.changeTitleView), name: WBPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WBHomeViewController.changeTitleView), name: WBPopoverAnimatorWillDismiss, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Actions
    
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
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
