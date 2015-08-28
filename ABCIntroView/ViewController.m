//
//  ViewController.m
//  ABCIntroView
//
//  Created by Adam Cooper on 2/5/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ViewController.h"
#import "ABCIntroView.h"
#import "ABCIntroView-Swift.h"

@interface ViewController () <CoreOnboardingViewDelegate>
@property CoreOnboardingView *introView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.introView = [[CoreOnboardingView alloc] initWithFrame:self.view.frame];
    self.introView.delegate = self;
    self.introView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.introView];  
}

#pragma mark - ABCIntroViewDelegate Methods

- (void)doneButtonPressed {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}

- (void)authorizeCamera {
    NSLog(@"authorize camera now");
}

- (void)authorizeMicrophone {
    NSLog(@"authorize microphone now");
}

- (void)authorizeGPS {
    NSLog(@"authorize GPS now");
}

- (void)authorizeNotifications {
    NSLog(@"authorize notifications now");
}

@end
