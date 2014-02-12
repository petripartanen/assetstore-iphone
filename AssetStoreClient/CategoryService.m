//
//  CategoryService.m
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "CategoryService.h"
#import "AssetCategory.h"
#import "constants.h"

@interface CategoryService ()

@property (strong, nonatomic) NSMutableArray *categories;

@end

@implementation CategoryService

-(NSMutableArray *)categories
{
    if (!_categories) {
        _categories = [[NSMutableArray alloc] init];
    }
    
    return _categories;
}

-(void)fetchCategories:(void (^)(NSArray *))handler
{
    NSString *categoryApiUrl = [HOST_ADDRESS stringByAppendingString:@"api/category"];
    NSURL *url = [NSURL URLWithString:categoryApiUrl];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonParsingError = Nil;
        
        if (!error) {
            NSArray *deserializedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonParsingError];
            
            if (!jsonParsingError) {
                [self.categories addObjectsFromArray:[self categoriesWithDeserializedJSON:deserializedJSON]];
            } else {
                NSLog(@"CategoryService: error parsing JSON");
            }
        } else {
            NSLog(@"CategoryService: error connecting to server\n %@", error);
        }
        
        handler(self.categories);
    }];
    
    [task resume];
}

-(NSArray *)categoriesWithDeserializedJSON:(NSArray *)deserializedJSON
{
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in deserializedJSON) {
        AssetCategory *category = [[AssetCategory alloc] init];
        
        category.name = [dictionary valueForKey:@"name"];
        
        [categories addObject:category];
        
        NSLog(@"Created category with name '%@'", category.name);
    }
    
    return categories;
    
}

@end
