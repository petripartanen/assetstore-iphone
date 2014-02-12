//
//  CategoryService.h
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CategoryServiceDelegate <NSObject>

-(void)categoryServiceDidUpdateCategories:(NSArray *)categories;

@end

@interface CategoryService : NSObject

-(void)fetchCategories:(void (^)(NSArray *categories))handler;

@end
