//
//  MapViewController.m
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController (){
    GMSMapView *mapView_;
    NSArray *locationArray;
    CLGeocoder *geocoder;
}

@end

@implementation MapViewController
#pragma mark EDIT COORDINATES
float CENTER_LATITUDE = 42.391468;
float CENTER_LONGITUDE = -72.526506;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    if (_goTo !=nil) {
        
        NSString *coordinates =[_goTo objectForKey:@"Coordinates"];
        float latitudeNumber=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:0]floatValue];
        float longitudeNumber=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:1]floatValue];
        CLLocationCoordinate2D coord= CLLocationCoordinate2DMake(latitudeNumber, longitudeNumber);
        [mapView_ animateToLocation:coord];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latitudeNumber, longitudeNumber);
        marker.title = [_goTo objectForKey:@"Name"];;
        marker.icon = [UIImage imageNamed:@"bubble_left.png"];
        marker.snippet=[_goTo objectForKey:@"Address"];
        marker.map = mapView_;        
    }
    [mapView_ animateToViewingAngle:45];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float lat;
    float lon;
    if (_goTo !=nil) {
        NSString *coordinates =[_goTo objectForKey:@"Coordinates"];
        lat=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:0]floatValue];
        lon=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:1]floatValue];
    }
    else{
        lat=CENTER_LATITUDE;
        lon=CENTER_LONGITUDE;
    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:17];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-88) camera:camera];
    //mapView_.autoresizesSubviews=YES;
    mapView_.autoresizingMask= UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:mapView_];
    // Create a GMSCameraPosition that tells the map to display the
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    [mapView_.settings setAllGesturesEnabled:YES];
    mapView_.settings.myLocationButton = YES;
    if (_goTo ==nil) {
        [self makeData];
    }
}
-(void)makeData{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"Locations" ofType:@"plist"];
    locationArray = [[NSArray alloc] initWithContentsOfFile:path];
    [self makeMarks];
    
}
-(CLLocationCoordinate2D)addressToCoord: (NSString*)address{
    
    __block CLLocationCoordinate2D location;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"%@",placemark);
        location = placemark.location.coordinate;
    }];
    return location;
}



-(void)makeMarks{
    //For Loop Goes Here
    for (int i=0; i<locationArray.count; i++) {
        
        NSString *coordinates =[[locationArray objectAtIndex:i]objectForKey:@"Coordinates"];
        @try{
            float latitudeNumber=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:0]floatValue];
            float longitudeNumber=[[[coordinates componentsSeparatedByString:@","] objectAtIndex:1]floatValue];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitudeNumber, longitudeNumber);
            marker.title = [[locationArray objectAtIndex:i]objectForKey:@"Name"];
            marker.snippet = [[locationArray objectAtIndex:i]objectForKey:@"Address"];
            if ([[[locationArray objectAtIndex:i]objectForKey:@"Section"] isEqualToString:@"Administrative"]) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
            }
            else if([[[locationArray objectAtIndex:i]objectForKey:@"Section"] isEqualToString:@"Academics"]) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor magentaColor]];
            }
            else if([[[locationArray objectAtIndex:i]objectForKey:@"Section"] isEqualToString:@"Research & Labs"]) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
            }
            else if([[[locationArray objectAtIndex:i]objectForKey:@"Section"] isEqualToString:@"Dining Halls"]) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
            }
            else if([[[locationArray objectAtIndex:i]objectForKey:@"Section"] isEqualToString:@"Points of Interest"]) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
            }
            marker.map = mapView_;
            
        }
        @catch (NSException *exception) {
            NSLog(@"NO");
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    _goTo=nil;
}
- (IBAction)normal:(id)sender {
    mapView_.mapType = kGMSTypeNormal;
    
}
- (IBAction)hybrid:(id)sender {
    mapView_.mapType = kGMSTypeHybrid;
}
- (IBAction)satellite:(id)sender {
    mapView_.mapType = kGMSTypeSatellite;
}
- (IBAction)terrain:(id)sender {
    mapView_.mapType = kGMSTypeTerrain;
}

- (IBAction)legalNotice:(id)sender {
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"LEGAL" message:[GMSServices openSourceLicenseInfo] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)clearPins:(id)sender {
    if ([_pinsOutlet.title isEqualToString:@"Clear Pins"]) {
        [mapView_ clear];
        _pinsOutlet.title=@"Show Pins";
    }
    else{
        _pinsOutlet.title=@"Clear Pins";
        [self makeMarks];
    }
}
@end
