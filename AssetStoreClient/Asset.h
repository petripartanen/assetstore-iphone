//
//  Asset.h
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asset : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *briefDescription;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *created;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *thumbnailUrl;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *categoryName;

-(UIImage *)thumbnail;
-(UIImage *)image;

@end
