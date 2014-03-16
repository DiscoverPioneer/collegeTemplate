//
//  TableViewController.m
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "TableViewController.h"

//MIGHT NEED TO ADD OR TAKE AWAY SECTION ARRAYS

@interface TableViewController (){
    NSMutableArray *academics;
    NSMutableArray *labs;
    NSMutableArray *interest;
    NSMutableArray *admin;
    NSMutableArray *dining;
    NSMutableArray *residential;
    NSMutableArray *filteredList;//Used for searching
    
    NSArray *sectionArray;
}

@end
BOOL isSearching = NO;

@implementation TableViewController

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
    NSLog(@"LOADED");
    // Do any additional setup after loading the view.
    academics=[[NSMutableArray alloc]init];
    labs=[[NSMutableArray alloc]init];
    interest=[[NSMutableArray alloc]init];
    admin=[[NSMutableArray alloc]init];
    dining=[[NSMutableArray alloc]init];
    residential=[[NSMutableArray alloc]init];
    sectionArray = [[NSArray alloc]initWithObjects:academics,labs,interest,admin,dining,residential,nil];
    [self makeData];
}

-(void)makeData{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"Locations" ofType:@"plist"];
    _locationsArray = [[NSArray alloc] initWithContentsOfFile:path];

    
    
    for (NSDictionary *dict in _locationsArray) {
        if ([[dict objectForKey:@"Section"]isEqualToString:@"Academics"]) {
            [academics addObject:dict];
        }
        else if ([[dict objectForKey:@"Section"]isEqualToString:@"Research & Labs"]){
            [labs addObject:dict];
            
        }
        else if ([[dict objectForKey:@"Section"]isEqualToString:@"Points of Interest"]){
            [interest addObject:dict];
            
        }
        else if ([[dict objectForKey:@"Section"]isEqualToString:@"Administrative"]){
            [admin addObject:dict];
            
        }
        else if ([[dict objectForKey:@"Section"]isEqualToString:@"Dining Halls"]){
            [dining addObject:dict];
        }
        else{
            [residential addObject:dict];
            
        }
        NSLog(@"Added %@",dict);
    }
    
}





#pragma mark TABLEVIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isSearching) {
        return 1;
    }
    else{
        return sectionArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = [sectionArray objectAtIndex:section];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSMutableArray *array = [sectionArray objectAtIndex:section];
    if (array.count>0)
        return [[array objectAtIndex:0]objectForKey:@"Section"];
    else
        return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableArray *array = [sectionArray objectAtIndex:indexPath.section];
    cell.textLabel.text=[[array objectAtIndex:indexPath.row]objectForKey:@"Name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
