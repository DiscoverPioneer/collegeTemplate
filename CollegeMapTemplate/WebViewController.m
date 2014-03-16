//
//  WebViewController.m
//  UMass Guide
//
//  Created by Phil Scarfi on 7/22/13.
//  Copyright (c) 2013 Phil Scarfi. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

#pragma mark EDIT
BOOL twoFeeds = FALSE;
NSString* PAGE1 = @"http://discoverpioneer.com/AppResources/umassNewsTwitter.html";
NSString* PAGE2 = @"http://discoverpioneer.com/AppResources/%23umassTweets.html";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PAGE1]]];
    if (!twoFeeds) {
        self.segmentedOutlet.hidden=YES;
    }
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_activity startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activity stopAnimating];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)segmentedControl:(id)sender {
    if (_segmentedOutlet.selectedSegmentIndex==0) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PAGE1]]];
    }
    else{
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PAGE2]]];
    }
    
    
}
@end
