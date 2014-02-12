//
//  AssetService.m
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "AssetService.h"
#import "Asset.h"
#import "constants.h"
#import "AssetCategory.h"

@interface AssetService ()

@property (strong, nonatomic) NSMutableArray *assets;

@end

@implementation AssetService


-(NSMutableArray *)assets
{
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    }
    
    return _assets;
}

-(void)fetchAssetsWithCategory:(AssetCategory *)category completionHandler:(void (^)(NSArray *))handler
{
    NSString *assetsApiUrl = [HOST_ADDRESS stringByAppendingString:@"api/asset"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:assetsApiUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *jsonParsingError = nil;
            
            NSArray *deserializedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonParsingError];
            
            if (!jsonParsingError) {
                NSArray *unfilteredAssets = [self assetsWithDeserializedJSON:deserializedJSON];
                
                // The following for-loop filters out all unwanted assets. Filtering should be done on server..
                for (Asset *asset in unfilteredAssets) {
                    if ([asset.categoryName isEqualToString:category.name]) {
                        [self.assets addObject:asset];
                    }
                }
            } else {
                NSLog(@"AssetService: Error parsing json");
            }
        } else {
            NSLog(@"AssetService: error connecting server \n %@", error);
        }
        
        handler(self.assets);
    }];
    
    [task resume];
}

-(NSArray *)assetsWithDeserializedJSON:(NSArray *)deserializedJSON
{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *entry in deserializedJSON) {
        Asset *asset = [[Asset alloc] init];
        
        asset.name = [entry valueForKey:@"name"];
        asset.briefDescription = [entry valueForKey:@"brief_description"];
        asset.description = [entry valueForKey:@"description"];
        asset.author = [entry valueForKey:@"author"];
        asset.version = [entry valueForKey:@"version"];
        asset.created = [entry valueForKey:@"created"];
        asset.categoryName = [entry valueForKeyPath:@"category.name"];
        
        if ([entry valueForKeyPath:@"thumbnail.web_path"]) {
            asset.thumbnailUrl = [HOST_ADDRESS stringByAppendingString:[entry valueForKeyPath:@"thumbnail.web_path"]];
        }
        
        if ([entry valueForKeyPath:@"image.web_path"]) {
            asset.imageUrl = [HOST_ADDRESS stringByAppendingString:[entry valueForKeyPath:@"image.web_path"]];
        }
        
        [assets addObject:asset];
        
        NSLog(@"Created asset with name '%@'", asset.name);
    }
    
    return assets;
}

@end
