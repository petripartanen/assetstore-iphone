//
//  AssetViewController.m
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "AssetListViewController.h"
#import "AssetDetailsViewController.h"
#import "Asset.h"
#import "AssetCell.h"
#import "AssetService.h"
#import "CategoryService.h"

@interface AssetListViewController ()

@property (strong, nonatomic) NSArray *assets;

@end

@implementation AssetListViewController

-(NSArray *)assets
{
    if (!_assets) {
        _assets = [[NSArray alloc] init];
    }
    
    return _assets;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:self.category.name];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemCancel target:nil action:nil];
    
    
    AssetService *assetService = [[AssetService alloc] init];
    
    [assetService fetchAssetsWithCategory:self.category completionHandler:^(NSArray *assets) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.assets = assets;
            
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
    return [self.assets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AssetCell";
    
    AssetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Asset *asset = [self.assets objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = asset.name;
    cell.briefDescriptionLabel.text = asset.briefDescription;
    cell.image.image = [asset thumbnail];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AssetDetailsSegue"]) {
        AssetDetailsViewController *controller = [segue destinationViewController];
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        controller.asset = [self.assets objectAtIndex:selectedIndexPath.row];
    }
}

@end
