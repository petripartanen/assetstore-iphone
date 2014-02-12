//
//  Asset.m
//  TabelViewExercise
//
//  Created by Petri Partanen on 11/02/14.
//  Copyright (c) 2014 Petri Partanen. All rights reserved.
//

#import "Asset.h"

@implementation Asset

-(UIImage *)thumbnail
{
    return [self imageWithURL:self.thumbnailUrl];
}

-(UIImage *)image
{
    return [self imageWithURL:self.imageUrl];
}

-(UIImage *)imageWithURL:(NSString *)url
{
    
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:url]];
    
    return [UIImage imageWithData:data];
}

@end
