//
//  SavedInformation.h
//  Slide48
//
//  Created by Thien Nguyen on 3/11/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavedInformation : NSObject
@property (nonatomic, retain) NSMutableArray* positions;
@property (nonatomic) NSInteger sizeBoard;
@property (nonatomic) NSInteger step;
@end
