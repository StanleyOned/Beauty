//
//  BeautyViewController.swift
//  Beauty
//
//  Created by Stanley Delacruz on 5/23/15.
//  Copyright (c) 2015 Delacruz Inc. All rights reserved.
//

import UIKit

class BeautyViewController: UIViewController {

    var filterImage: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    var picReady: Bool!
    @IBOutlet weak var fgView: UIView!
    @IBOutlet weak var layout: UIView!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    let customAnimation = CustomPresentation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).CGColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.9).CGColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 1
        imageView.layer.opacity  = 0.7
        //view.layer.shadowOffset
       
        
        buttonsSetup()
        layoutSetup()
        fgViewSetup()
        emitterAnimation()
        imageGradient()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (picReady != nil) {
            performSegueWithIdentifier("show", sender: self)
        }
        picReady = nil
    }
    
    func buttonsSetup() {
        libraryButton.layer.cornerRadius = 15
        cameraButton.layer.cornerRadius = 15
        
        //libraryButton
        libraryButton.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).CGColor
        cameraButton.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).CGColor
        libraryButton.layer.borderWidth = 3
        cameraButton.layer.borderWidth = 3
        
        libraryButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        cameraButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        libraryButton.tintColor = UIColor.whiteColor()
        cameraButton.tintColor = UIColor.whiteColor()
    }
    
    func imageGradient() {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0,0.9]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.65, y: 0.65)
        gradient.colors = [UIColor.blackColor(), UIColor.clearColor().colorWithAlphaComponent(0.7)]
        gradient.frame = CGRect(x: 0, y: 0, width: layout.bounds.size.width, height: layout.bounds.size.height)
        gradient.opacity = 1
        layout.layer.addSublayer(gradient)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true 
    }
    
    func emitterAnimation() {
        
        let rect = CGRect(x: 0.0, y: view.bounds.size.height / 2 + 10, width: view.bounds.size.width, height: view.bounds.size.height)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        imageView.layer.addSublayer(emitter)
        emitter.emitterShape = kCAEmitterLayerRectangle
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitter.emitterSize = rect.size
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "Leaf.png")!.CGImage
        emitterCell.birthRate = 8
        emitterCell.lifetime = 5.0
        emitter.emitterCells = [emitterCell]
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 10
        emitterCell.velocity = 20.0
        //emitterCell.emissionLongitude = CGFloat(-M_PI_2)
        emitterCell.velocityRange = 200.0
        emitterCell.color = UIColor(red: 0.8, green: 1.0, blue: 1.0, alpha: 0.8).CGColor
        emitterCell.emissionRange = CGFloat(M_PI_2)
        //emitterCell.scale = 0.8
        //emitterCell.scaleRange = 0.8
        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        emitterCell.spin = 10
    }
    
    
    func layoutSetup() {
        layout.layer.cornerRadius = CGRectGetWidth(layout.bounds) / 2
        layout.layer.opacity = 0.9
        layout.layer.borderColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).CGColor
        layout.layer.borderWidth = 4
        layout.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        
        let center = layout.center
        
        layout.center = CGPoint(x: fgView.frame.size.width / 2, y: -200)
        
        UIView.animateWithDuration(2.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
            self.layout.center = center
            
            }, completion: nil)
    }
    
    func fgViewSetup() {
        fgView.backgroundColor = UIColor.blackColor()
        fgView.layer.shadowColor = UIColor.blackColor().CGColor
        fgView.layer.shadowOpacity = 1.0
        fgView.layer.shadowRadius = 0.9
        
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        return .LightContent
    }
    
    @IBAction func takePhoto() {
        picReady = true
        let image = UIImagePickerController()
        image.allowsEditing = true
        image.sourceType = .Camera
        image.delegate = self
        presentViewController(image, animated: true, completion: nil)
        
    }

    
    @IBAction func takeFromLibrary() {
        picReady = true
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
        let image = UIImagePickerController()
        image.allowsEditing = true
        image.sourceType = .PhotoLibrary
        image.delegate = self
        presentViewController(image, animated: true, completion: nil)
        } else if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .PhotoLibrary
            image.delegate = self
            presentViewController(image, animated: true , completion: nil)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "show" {
            let controller = segue.destinationViewController as! ViewController
            controller.beauty = sender as! BeautyViewController
            controller.transitioningDelegate = self 
        }
    }
}

extension BeautyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        filterImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        picReady = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension BeautyViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimation
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customAnimation.presenting = false
        return customAnimation
    }
}
