//
//  ViewController.swift
//  ParallaxTableView
//
//  Created by hongfei xie on 16/2/21.
//  Copyright © 2016年 hongfei xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ImgHeight: CGFloat = 250
    let speed: CGFloat = 10
    
    @IBOutlet weak var parallaxTable: UITableView!
    
    let imageNameArray = ["1", "2", "3", "4", "5", "6", "7", "8","1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ParallaxTableViewCell
       
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.bgImgView.image = UIImage(named: imageNameArray[indexPath.row])
        
//        let offset = (parallaxTable.contentOffset.y - view.frame.origin.y) / ImgHeight * speed
//        cell.topCon.constant = offset - 50
//        cell.btmCon.constant = -offset - 50

        
        return cell
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = (parallaxTable.contentOffset.y - self.view.frame.origin.y) / ImgHeight * speed
        
        for cell in parallaxTable.visibleCells as! [ParallaxTableViewCell] {
            
            cell.topCon.constant = offset - 50
            cell.btmCon.constant = -offset  - 50
        }
    }
}

