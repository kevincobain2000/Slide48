//
//  SavePuzzleBoard.h
//  Slide48
//
//  Created by Thien Nguyen on 3/9/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "PuzzleBoard.h"

@interface SavePuzzleBoard : NSObject
- (void)initCoreData;
- (void)insertNewGame:(NSNumber*)size positions:(NSArray*)posArray;
- (NSArray*) searchGame:(NSNumber*)size;
- (void)updateGame:(NSNumber*)size positions:(NSArray*)posArray;
- (void)deleteGame:(NSNumber*)size;
- (void)loadGame;
- (PuzzleBoard*)lastPlayedGame;
@end
