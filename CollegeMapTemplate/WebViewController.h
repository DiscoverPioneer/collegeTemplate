//
//  WebViewController.h
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/16/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
- (IBAction)segmentedControl:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedOutlet;
@end
