//
//  ViewController.m
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

#define TIME_ZONE @"America/New_York"
#define SCHOOL_NAME @"University Name"


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = SCHOOL_NAME;
    [self updateTime];
}

//Updates the timer
- (void)updateTime {
    
    // Without this, the timer would never be erased from the code.
    // This would cause a memory overload.
    [updateTimer invalidate];
    updateTimer = nil;
    
    currentTime = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:TIME_ZONE]];
    [timeFormatter setTimeStyle:NSDateFormatterMediumStyle];
    lblTime.text = [timeFormatter stringFromDate:currentTime];
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"BuildingFinder"]){
        TableViewController *TVC;
        TVC= [segue destinationViewController];

        
    }
}

@end
