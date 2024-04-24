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
            timeLabel.textColor = .black
            timeLabel.font = .boldSystemFont(ofSize: 19)
            
            for imageUrl in snap.imageUrlArray{
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
                
            }
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            let frameWidth: CGFloat = 380
            let frameHeight: CGFloat = 500
            
            let x = (screenWidth - frameWidth) / 2
            let y = (screenHeight - frameHeight) / 2
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: x, y: y, width: frameWidth, height: frameHeight))
            imageSlideShow.backgroundColor = UIColor.systemBackground
            
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.black
            pageIndicator.pageIndicatorTintColor = UIColor.lightGray
            imageSlideShow.pageIndicator = pageIndicator
            
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.addSubview(timeLabel)
            self.view.bringSubviewToFront(timeLabel)
            
        }

        

        
    }
    


}
