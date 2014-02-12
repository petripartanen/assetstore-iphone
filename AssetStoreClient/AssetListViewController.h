//
//  AssetViewController.h
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetCategory.h"

@interface AssetListViewController : UITableViewController

@property (strong, nonatomic) AssetCategory *category;

@end
