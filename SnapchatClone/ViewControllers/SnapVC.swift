//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

class SnapVC: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
  //  var selectedTime : Int?
    var inputArray = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     if let time = selectedTime{
            
  //          timeLabel.text = "Time Left: \(time)h"}
        
        if let snap = selectedSnap{
            
            timeLabel.text = "Time Left: \(snap.difference)h"
            
            for imageUrl in snap.imageUrlArray{
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
                
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 40, y: 50, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.7))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
            
        }
        
        

        
    }
    


}
