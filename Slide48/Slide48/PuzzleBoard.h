//
//  PuzzleBoard.h
//  Slide48
//
//  Created by Thien Nguyen on 3/10/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PuzzleBoard : NSManagedObject

@property (nonatomic, retain) NSNumber * sizeBoard;
@property (nonatomic, retain) id positions;

@end
