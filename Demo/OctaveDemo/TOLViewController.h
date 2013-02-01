//
//  TOLViewController.h
//  OctaveTest
//
//  Created by Lars Anderson on 1/31/13.
//  Copyright (c) 2013 @theonlylars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewData;

@end
