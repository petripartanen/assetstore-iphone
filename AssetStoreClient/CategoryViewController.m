//
//  CategoryViewController.m
//  TableViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryService.h"
#import "AssetCategory.h"
#import "AssetListViewController.h"

@interface CategoryViewController ()

@property (strong, nonatomic) NSArray *categories;

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemCancel target:nil action:nil];
    
    CategoryService *categoryService = [[CategoryService alloc] init];
    
    [categoryService fetchCategories:^(NSArray *categories) {
        self.categories = categories;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AssetCategory *category = (AssetCategory *)[self.categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = category.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AssetSegue"]) {
        int selectedRow = [self.tableView indexPathForSelectedRow].row;
        AssetCategory *selectedCategory = [self.categories objectAtIndex:selectedRow];

        AssetListViewController *destinationController = [segue destinationViewController];
        destinationController.category = selectedCategory;
    }
}

@end
