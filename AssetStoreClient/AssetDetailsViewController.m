//
//  AssetDetailsViewController.m
//  TableViewExercise
//
//  Created by Petri Partanen on 12/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "AssetDetailsViewController.h"

@interface AssetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation AssetDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameLabel.text = self.asset.name;
    self.authorLabel.text = self.asset.author;
    self.versionLabel.text = self.asset.version;
    self.createdLabel.text = self.asset.created;
    self.descriptionLabel.text = self.asset.description;
    self.imageView.image = [self.asset image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
