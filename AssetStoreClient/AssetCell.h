//
//  AssetCell.h
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
