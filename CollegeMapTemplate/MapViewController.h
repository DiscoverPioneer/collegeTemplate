//
//  MapViewController.h
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
- (IBAction)normal:(id)sender;
- (IBAction)hybrid:(id)sender;
- (IBAction)satellite:(id)sender;
- (IBAction)terrain:(id)sender;
- (IBAction)legalNotice:(id)sender;
- (IBAction)clearPins:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pinsOutlet;

@property int goNumber;
@property (weak, nonatomic) NSDictionary *goTo;

@end
