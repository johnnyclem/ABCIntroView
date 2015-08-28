//
//  CoreOnboardingView.swift
//  ABCIntroView
//
//  Created by John Clem on 8/27/15.
//  Copyright © 2015 Adam Cooper. All rights reserved.
//

import UIKit

@objc protocol CoreOnboardingViewDelegate {
    func doneButtonPressed()
    func authorizeCamera()
    func authorizeMicrophone()
    func authorizeGPS()
    func authorizeNotifications()
}

class CoreOnboardingView: UIView, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let _scrollView = UIScrollView(frame: self.frame)
        return _scrollView
    }()

    func configureScrollView() {
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: self.frame.size.width*4, height: self.scrollView.frame.size.height)
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: false)
    }
    
    lazy var pageControl: UIPageControl = {
       let _pageControl = UIPageControl(frame: CGRect(x: 0.0, y: self.frame.size.height*0.8, width: self.frame.size.width, height: 10.0))
        _pageControl.currentPageIndicatorTintColor = UIColor(red: 0.153, green: 0.533, blue: 0.796, alpha: 1.0)
        _pageControl.numberOfPages = 4
        return _pageControl
    }()
    
    lazy var doneButton: UIButton = {
        let _doneButton = UIButton(frame: CGRect(x: self.frame.size.width*0.1, y: self.frame.size.height*0.85, width: self.frame.size.width*0.8, height: 60.0))
        _doneButton.tintColor = UIColor.whiteColor()
        _doneButton.setTitle("Let's Go!", forState: .Normal)
        _doneButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        _doneButton.backgroundColor = UIColor(red: 0.153, green: 0.533, blue: 0.796, alpha: 1.0)
        _doneButton.layer.cornerRadius = 5
        _doneButton.clipsToBounds = true
        _doneButton.addTarget(self, action: Selector("onDoneButtonPressed"), forControlEvents: .TouchUpInside)
        return _doneButton
    }()
    
    var delegate: CoreOnboardingViewDelegate?
    
    var views = [UIView]()
    
    override init(frame: CGRect) {
        // Call super
        super.init(frame: frame)
        // Setup background imageView
        let backgroundImageView = UIImageView(frame: frame)
        backgroundImageView.image = UIImage(named: "Intro_Screen_Background")
        self.addSubview(backgroundImageView)
        // Setup scrollView
        self.configureScrollView()
        self.addSubview(scrollView)
        self.scrollView.addSubview(self.onboardingScreenWithTitle("Welcome to Filmic Pro", index: 0, description: "Let's get you up to speed on what's new", heroImage: nil))
        self.scrollView.addSubview(self.onboardingScreenWithTitle("Camera / Microphone", index: 1, description: "First off, we need access to the Camera and Microphone", heroImage: nil))
        self.scrollView.addSubview(self.onboardingScreenWithTitle("Enable GPS?", index: 2, description: "Filmic Pro can automatically tag your videos with your location data.", heroImage: nil))
        self.scrollView.addSubview(self.onboardingScreenWithTitle("Allow Notifications?", index: 3, description: "Filmic Pro can keep you up to date with notifications.", heroImage: nil))
        // Setup Page Control
        self.addSubview(pageControl)
        // Setup Done Button
        self.addSubview(doneButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onDoneButtonPressed(sender: UIButton) {
        self.delegate?.doneButtonPressed()
    }
    
    //MARK: Onboarding Screens
    func onboardingScreenWithTitle(title: String, index: CGFloat, description: String, heroImage: UIImage?) -> UIView {
        
        // Create a new view
        let view = UIView(frame: CGRect(x: index*self.frame.size.width, y: 0.0, width: self.frame.size.width, height: self.frame.size.height))
        
        // Setup the title label
        let titleLabel = UILabel(frame: CGRect(x: 0, y: self.frame.size.height*0.05, width: self.frame.size.width*0.8, height: 60.0))
        titleLabel.center = CGPoint(x: self.center.x, y: self.frame.size.height*0.1)
        titleLabel.text = title
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 40)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        // Setup the description label
        let descriptionLabel = UILabel(frame: CGRect(x: self.frame.size.width*0.1, y: self.frame.size.height*0.7, width: self.frame.size.width*0.8, height: 60.0))
        descriptionLabel.text = description
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        descriptionLabel.textColor = UIColor.whiteColor()
        descriptionLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.center = CGPoint(x: self.center.x, y: self.frame.size.height*0.7)
        view.addSubview(descriptionLabel)
        
        // Setup the image view
        guard heroImage != nil else { return view }
        let heroImageView = UIImageView(frame: CGRect(x: self.frame.size.width*0.1, y: self.frame.size.height*0.1, width: self.frame.size.width*0.8, height: self.frame.size.width))
        heroImageView.contentMode = UIViewContentMode.ScaleAspectFit
        heroImageView.image = heroImage!
        view.addSubview(heroImageView)
        
        return view
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Get the page width
        let pageWidth = CGRectGetWidth(self.bounds)
        // Calculate the current page from the offset
        let pageFraction = self.scrollView.contentOffset.x / pageWidth
        // Update the page control dots
        pageControl.currentPage = Int(floor(pageFraction))
    }
}
