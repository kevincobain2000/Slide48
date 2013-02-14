//
//  ViewController.m
//  Slide48
//
//  Created by Pulkit Kathuria on 2/14/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize board;

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Initialize the Shared Data
    sharedData = [SharedData sharedData];
    [self difficultyLevel];
    
    gambar = [UIImage imageNamed:@"ff.png"];
    
    // show the full image first in the view
    UIImageView *fullImage = [[UIImageView alloc] initWithImage:gambar];
    fullImage.frame = board.bounds;
    [board addSubview:fullImage];
}

- (void)viewDidUnload {
    [self setBoard:nil];

    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - My Functions

-(void) difficultyLevel{
    NSLog(@"AutoSetting difficulty level = 0");
    difficultyLevel = 0;
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 300, 300, 70) Titles:[NSArray arrayWithObjects:NSLocalizedString(@"Easy", @"Easy"), NSLocalizedString(@"Medium", @"Medium"), NSLocalizedString(@"Hard", @"Hard"), nil]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [filter setHandlerColor:[UIColor yellowColor]];
    [filter setProgressColor:[UIColor magentaColor]];
    [filter setTitlesFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:14]];
    [self.view addSubview:filter];
}
#pragma mark - Slider delegate method
-(void)filterValueChanged:(SEFilterControl *) sender{
    NSLog(@"Changing difficulty level %d", sender.SelectedIndex);
    difficultyLevel = sender.SelectedIndex;
}


#pragma mark - Puzzle View delegate method
/*
 This delegate method is fired when the puzzle board is finished
 */
- (void)puzzleBoardDidFinished:(IAPuzzleBoardView *)puzzleBoard {
    // This method is fired every time the board is finished, you can make this method doing whatever you want. Mine, it does a simple animation :
    // 1. Add the full image, set it's alpha with 0.0. Animate it to 1.0.
    // 2. Upon completion set the view so that it can't interact, and set the label to 'start'
    UIImageView *fullImage = [[UIImageView alloc]initWithImage:gambar];
    fullImage.frame = board.bounds;
    fullImage.alpha = 0.0;
    [board addSubview:fullImage];
   
    [UIView animateWithDuration:.4
                     animations:^{
                         // set the alpha of full image to 1.0
                         // atur alpha gambar penuh tersebut menjadi 1.0
                         fullImage.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         // set the view interaction and set the label text
                         // atur status interaksi view dan teks dari label
                         NSLog(@"Congrats! You finish this %d x %d puzzle with %d steps", (difficultyLevel+3), (difficultyLevel+3), step);
                         [board setUserInteractionEnabled:NO];
                     }];
}

- (void)puzzleBoard:(IAPuzzleBoardView *)board emptyTileDidMovedTo:(CGPoint)tilePoint {
    // You can add some cool sound effects here
    // Anda bisa tambahkan efek suara yang keren di sini
    NSLog(@"Tile moved, add Sounds or something");
    step += 1;
}




#pragma mark - IB Actions
- (IBAction)start:(id)sender {
    step = 0;
    [board setUserInteractionEnabled:YES];
    [board playWithImage:gambar andSize:(difficultyLevel+2)];    //CHANGE THIS TO 3
}
@end
