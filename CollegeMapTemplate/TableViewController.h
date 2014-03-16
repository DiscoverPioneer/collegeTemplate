//
//  TableViewController.h
//  CollegeMapTemplate
//
//  Created by Phil Scarfi on 3/15/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *locationsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
