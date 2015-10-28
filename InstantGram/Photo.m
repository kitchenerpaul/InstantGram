//
//  Photo.m
//  InstantGram
//
//  Created by cory Sturgis on 10/28/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithPhoto:(UIImage *)photo{
    self = [super init];
    if (self){
        self.image = photo;
    }
    return self;
}


@end
