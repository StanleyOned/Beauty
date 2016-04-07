//
//  ViewController.swift
//  Beauty
//
//  Created by Stanley Delacruz on 5/14/15.
//  Copyright (c) 2015 Delacruz Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var blurEffects: [String] = ["None","Chrome","Fade","Instant", "Mono","Noir", "Process", "Transfer",
                                  "Sepia", "Posterize", "Invert", "False", "Maximum",
                                 "Minimum", "Circular", "Dot", "Hatched", "Line"]
    var image: UIImage?
    let gradientLayer = CAGradientLayer()
    var beauty: BeautyViewController!
    var newImage: UIImage?
   
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        imageView.image = beauty.filterImage
        // Do any additional setup after loading the view, typically from a nib.
        image = imageView.image
        view.backgroundColor = UIColor.blackColor()
        navigationController?.prefersStatusBarHidden()
        bottomView.layer.borderWidth = 3
        bottomView.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0).CGColor
        bottomView.layer.cornerRadius = 2
        bottomView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        
        bottomView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomView.layer.shadowOpacity = 10
        
        
        topView.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0).CGColor
        topView.layer.borderWidth = 3
        topView.layer.cornerRadius = 7
        topView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        
        topView.layer.shadowColor = UIColor.blackColor().CGColor
        topView.layer.shadowOpacity = 10
        
        gradientLayer.colors = [UIColor.whiteColor().CGColor, UIColor.whiteColor().colorWithAlphaComponent(0.4)]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bottomView.frame.size.width, height: bottomView.frame.size.height)
        bottomView.layer.addSublayer(gradientLayer)
        
        
        
       let collectionViewLayout = UICollectionViewFlowLayout()
        let width = CGRectGetWidth(view.frame) / 4
        let layout = collectionViewLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        collectionView!.indicatorStyle = .Black
        collectionView?.bounds.size.width -= view.bounds.size.width
        collectionView?.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 0.8)
        
        //collectionView?.layer.cornerRadius = 10
        
    
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 1.5
        anim.fromValue = 0.5
        anim.toValue = 1.0
        collectionView?.layer.addAnimation(anim, forKey: nil)
        collectionView.bounds.size.width  -= self.view.bounds.size.width
        UIView.animateWithDuration(1.0, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { _ in
            self.collectionView?.bounds.size.width += self.view.bounds.size.width
            }, completion: nil)
        
    }

    
    @IBAction func dismissVC(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func rotateImage(sender: UIButton) {
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
            }, completion: { _ in
                self.newImage = self.imageView.image
        
        })
        
    }
   
    
    func takeblurFilter(string: String)  {
        var filter = ""
        
        switch string {
            case "Chrome":
            filter = "CIPhotoEffectChrome"
            case "Fade":
            filter = "CIPhotoEffectFade"
            case "Instant":
            filter = "CIPhotoEffectInstant"
            case "Mono":
            filter = "CIPhotoEffectMono"
            case "Noir":
            filter = "CIPhotoEffectNoir"
            case "Process":
            filter = "CIPhotoEffectProcess"
            case "Transfer":
            filter = "CIPhotoEffectTransfer"
            case "Sepia":
            filter = "CISepiaTone"
            case "Posterize":
            filter = "CIColorPosterize"
            case "Invert":
            filter = "CIColorInvert"
            case "False":
            filter = "CIFalseColor"
            case "Maximum":
            filter = "CIMaximumComponent"
            case "Minimum":
            filter = "CIMinimumComponent"
            case "Circular":
            filter = "CICircularScreen"
            case "Dot":
            filter = "CIDotScreen"
            case "Hatched":
            filter = "CIHatchedScreen"
            case "Line":
            filter = "CILineScreen"
            case "None":
                imageView.image = image
            
            default:
            break
        }
        if filter == "" {
            
            
        } else {
            filterThem(filter)
        }
    }
  
    @IBAction func saveImage(sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: "Save image", preferredStyle: .ActionSheet)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: { _ in
            self.saveImage()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveImage() {
        if newImage == nil {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, nil, nil)
        } else {
            UIImageWriteToSavedPhotosAlbum(newImage!, self, nil, nil)
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        let shareImage: UIImage = imageView.image!
        let array: [UIImage] = [shareImage]
        let vc = UIActivityViewController(activityItems: array , applicationActivities: nil)
        presentViewController(vc, animated: true , completion: nil)
        
    }
    
    private func filterThem(filters: String) {
        
        let imageOrientation = imageView.image?.imageOrientation
        let scale = imageView.image?.scale
        
        let inputImage = CIImage(image: imageView.image!)
        let context = CIContext(options: nil)
        
        // let filterParameter = [kCIInputImageKey: inputImage]
        let filter = CIFilter(name: filters)
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        
        
        let outputImage = filter!.outputImage
        let imageRef = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        
        imageView.image = UIImage(CGImage: imageRef, scale: scale!, orientation: imageOrientation!)
        
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier("Filters", forIndexPath: indexPath) as! FilterCell
        let item = blurEffects[indexPath.item]
        let label = cell.viewWithTag(100) as! UILabel!
        label.text = item
        
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blurEffects.count
    }
    
     func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.cornerRadius = CGRectGetHeight(cell.bounds) / 2
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 4
        cell.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 0.8)
        
       /* cell.layer.shadowOpacity = 20
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5 */
        

    }
    
    
    //MARK: Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        imageView.image = image
        
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            let label = cell.viewWithTag(100) as! UILabel
            var text = ""
            text = label.text!
            takeblurFilter(text)
            
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .CurveEaseInOut, animations: {
                cell.backgroundColor = UIColor.blackColor()
                cell.layer.borderColor = UIColor.whiteColor().CGColor
                }, completion: { _ in })
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 0.8)
            cell.layer.borderColor = UIColor.blackColor().CGColor
        }
    }
    
}
   


