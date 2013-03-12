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
- (void)insertNewGame:(NSNumber*)size positions:(NSArray*)posArray
{
    NSEntityDescription* entitydesc = [NSEntityDescription entityForName:@"PuzzleBoard" inManagedObjectContext:context];
    NSManagedObject* newPuzzleBoard = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    [newPuzzleBoard setValue:size forKey:@"sizeBoard"];
    
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:posArray];
    [newPuzzleBoard setValue:arrayData forKey:@"positions"];
    [newPuzzleBoard setValue:[NSNumber numberWithInt:0] forKey:@"step"];
    
    NSError* error;
    [context save:&error];
    NSLog(@"Da save game:");

}
- (SavedInformation*) searchGame:(NSNumber*)size
{
    NSEntityDescription* entitydesc = [NSEntityDescription entityForName:@"PuzzleBoard" inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sizeBoard == %@",size];
    [request setPredicate:predicate];
    
    NSError* error;
    NSArray* matchingData = [context executeFetchRequest:request error:&error];
    if(matchingData.count <=0)
    {
        NSLog(@"No data is matched");
        return NULL;
    }else
    {
        SavedInformation *savedInfo = [[SavedInformation alloc]init];
        NSManagedObject* first = [matchingData lastObject];
        
        NSNumber* firstSize = [first valueForKey:@"sizeBoard"];
        NSNumber* firstStep = [first valueForKey:@"step"];
        NSData* positions= [first valueForKey:@"positions"];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:positions];
        
        savedInfo.sizeBoard = [firstSize integerValue];
        savedInfo.positions = array;
        savedInfo.step = [firstStep integerValue];
        return savedInfo;
    }  
}
- (void)updateGame:(NSNumber*)size positions:(NSArray*)posArray step:(NSNumber*)step
{
    NSEntityDescription* entitydesc = [NSEntityDescription entityForName:@"PuzzleBoard" inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sizeBoard == %@",size];
    [request setPredicate:predicate];
    
    NSError* error;
    NSArray* matchingData = [context executeFetchRequest:request error:&error];
    if(matchingData.count <=0)
    {
        NSLog(@"No data is matched");
    }else
    {
        NSManagedObject* first = [matchingData lastObject];
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:posArray];
        [first setValue:arrayData forKey:@"positions"];
        [first setValue:step forKey:@"step"];
        [context save:&error];
        
    }
}
- (void)deleteGame:(NSNumber*)size
{
    NSEntityDescription* entitydesc = [NSEntityDescription entityForName:@"PuzzleBoard" inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sizeBoard == %@",size];
    [request setPredicate:predicate];
    
    NSError* error;
    NSArray* matchingData = [context executeFetchRequest:request error:&error];
    if(matchingData.count <=0)
    {
        NSLog(@"No data is matched");
    }else
    {
        NSManagedObject* first = [matchingData lastObject];
        [context deleteObject:first];
        [context save:&error];
    }
}
- (PuzzleBoard*)lastPlayedGame{
    
}
@end
