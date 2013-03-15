//
//  PuzzleLibraryController.m
//  Puzzle
//
//  Created by Andrea Barbon on 10/05/12.
//  Copyright (c) 2012 Università degli studi di Padova. All rights reserved.
//

#import "LoadPuzzleController.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_SIZE 240

@implementation LoadPhotoCell

- (void)viewDidLoad
{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    
}

@synthesize photo;

@end



@implementation LoadPuzzleController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    thumbs = [[NSArray alloc] initWithArray:[self imagesForPuzzle]];
    paths = [[NSArray alloc] initWithArray:[self pathsForImages]];
    contents = [[NSArray alloc] initWithArray:[self joinData]];
    
    sharedData = [SharedData sharedData];
    
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //AudioPlayers
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Button" ofType:@"wav"]];
    audioPlayerBack = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;
    [audioPlayerBack prepareToPlay];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSMutableArray*)shuffleArray:(NSMutableArray*)array {
    
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [array exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return array;
}

#pragma mark - Table view data source

- (NSArray*)joinData {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:paths.count];
    for (int i=0; i<paths.count; i++) {
        
        NSArray *objects = [NSArray arrayWithObjects:[paths objectAtIndex:i], [thumbs objectAtIndex:i], nil];
        NSArray *keys = [NSArray arrayWithObjects:@"Path", @"Thumb", nil];
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        [tempArray addObject:dict];
    }
    
    return [NSArray arrayWithArray:[self shuffleArray:tempArray]];
    
}

- (NSArray*)imagesForPuzzle {
    
    NSArray *dirContents = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:dirContents.count];
    for (NSString *string in dirContents)
    {
        if ([string hasSuffix:@"_puzzle_thumb.jpg"]  ||
            [string hasSuffix:@"_puzzle_thumb.jpeg"] ||
            [string hasSuffix:@"_puzzle_thumb.png"]  ||
            [string hasSuffix:@"_puzzle_thumb.JPG"]  ||
            [string hasSuffix:@"_puzzle_thumb.JPEG"] ||
            [string hasSuffix:@"_puzzle_thumb.PNG"]
            ) {
            
            [tempArray addObject:[UIImage imageWithContentsOfFile:string]];
        }
    }
    
    return [NSArray arrayWithArray:tempArray];
    
}

- (NSArray*)pathsForImages {
    
    NSArray *dirContents = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:dirContents.count];
    for (NSString *string in dirContents)
    {
        if ([string hasSuffix:@"_puzzle.jpg"]  ||
            [string hasSuffix:@"_puzzle.jpeg"] ||
            [string hasSuffix:@"_puzzle.png"]  ||
            [string hasSuffix:@"_puzzle.JPG"]  ||
            [string hasSuffix:@"_puzzle.JPEG"] ||
            [string hasSuffix:@"_puzzle.PNG"]
            ) {
            
            [tempArray addObject:string];
        }
    }
    return [NSArray arrayWithArray:tempArray];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        return 50;
        
    } else {
        
        return self.view.bounds.size.width;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return contents.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"Back";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
            cell.selectedBackgroundView = v;
        }
        
        cell.textLabel.text = NSLocalizedString(@"Back",@"");
        cell.textLabel.textColor = [UIColor yellowColor];
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:26];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        return cell;
        
        
    } else {
        
        static NSString *CellIdentifier = @"Cell";
        LoadPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            float w = self.view.bounds.size.width;
            cell = [[LoadPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.photo = [[UIImageView alloc] initWithFrame:CGRectMake((w-IMAGE_SIZE)/2, (w-IMAGE_SIZE)/2, IMAGE_SIZE, IMAGE_SIZE-40)];

            cell.photo.layer.cornerRadius = 10;
            
            cell.photo.layer.masksToBounds = YES;
            
            [cell addSubview:cell.photo];
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = [UIColor magentaColor];
            cell.selectedBackgroundView = v;
        }
        
        //NSString *path = [content objectAtIndex:indexPath.row];
        cell.photo.image = [[contents objectAtIndex:indexPath.row] objectForKey:@"Thumb"];
        return cell;
        
        
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //Take the Path and load into Share Data
    NSLog(@"index of photo section %i",indexPath.section);
    if (!indexPath.section == 0) {
        sharedData.imagePathFromPuzzleLib = [[contents objectAtIndex:indexPath.row] objectForKey:@"Path"];
        sharedData.shouldPlayAudio = [NSNumber numberWithBool:YES];
    }
    else{
        [audioPlayerBack play];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
