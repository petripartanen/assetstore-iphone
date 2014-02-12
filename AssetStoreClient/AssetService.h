//
//  AssetService.h
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetCategory.h"

@interface AssetService : NSObject

-(void)fetchAssetsWithCategory:(AssetCategory *)category completionHandler:(void (^)(NSArray *))handler;

@end
