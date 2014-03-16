//
//  ViewController.h
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *lblTime; //Make sure to connect this to the label in the storyboard/xib
    NSDate *currentTime;
    NSTimer *updateTimer;
}

@end
