//
//  SharedData.m
//  temp
//
//  Created by Pulkit Kathuria on 11/20/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import "SharedData.h"


@implementation SharedData


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sharedBool = [NSNumber numberWithBool:NO];
        self.difficultyLevel = [NSNumber numberWithInt:0];
    }
    return self;
}


+(SharedData *) sharedData;
{
    static SharedData* _sharedData;
    if (!_sharedData)
        _sharedData = [[SharedData alloc] init];
    return _sharedData;
}



@end
