//
//  SavePuzzleBoard.m
//  Slide48
//
//  Created by Thien Nguyen on 3/9/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import "SavePuzzleBoard.h"
@interface SavePuzzleBoard ()
{
    NSManagedObjectContext* context;
}
@end
@implementation SavePuzzleBoard
- (void)initCoreData{
    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}
- (void)insertNewGame:(NSNumber*)size{
    NSEntityDescription* entitydesc = [NSEntityDescription entityForName:@"PuzzleBoard" inManagedObjectContext:context];
    NSManagedObject* newPuzzleBoard = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    [newPuzzleBoard setValue:size forKey:@"size"];
    
    NSError* error;
    [context save:&error];
    NSLog(@"Da save game:");

}
@end
