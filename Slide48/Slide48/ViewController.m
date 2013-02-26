//
//  ViewController.m
//  Slide48
//
//  Created by Pulkit Kathuria on 2/14/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RNBlurModalView.h"
#import "Animations.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize board;

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    NSLog(@"View Did Load ViewController.m");
    //Initialize the Shared Data
    sharedData = [SharedData sharedData];
    
    
     if (![sharedData.imagePathFromPuzzleLib isEqualToString:@""]) {
         gambar = [UIImage imageWithContentsOfFile:sharedData.imagePathFromPuzzleLib];
         UIImageView *fullImage = [[UIImageView alloc] initWithImage:gambar];
         fullImage.frame = board.bounds;
         [board addSubview:fullImage];
         self.imageViewShowPicture.image = [UIImage imageWithContentsOfFile:sharedData.imagePathFromPuzzleLib];
     }
     else{
         gambar = [UIImage imageNamed:@"4_puzzle.jpg"];
         UIImageView *fullImage = [[UIImageView alloc] initWithImage:gambar];
         fullImage.frame = board.bounds;
         [board addSubview:fullImage];
         self.imageViewShowPicture.image = [UIImage imageNamed:@"4_puzzle.jpg"];
     }
    
    step = 0;
    [board setUserInteractionEnabled:YES];
    [board playWithImage:gambar andSize:([sharedData.difficultyLevel intValue]+2)];    //CHANGE THIS TO 3
    
    
}

- (void)viewDidUnload {
    [self setBoard:nil];



    [self setLabelNumOfMoves:nil];
    [self setImageViewShowPicture:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
                         NSLog(@"Congrats! You finish this %d x %d puzzle with %d steps", ([sharedData.difficultyLevel intValue]+3), ([sharedData.difficultyLevel intValue]+3), step);

                         [board setUserInteractionEnabled:NO];
                     }];
}

- (void)puzzleBoard:(IAPuzzleBoardView *)board emptyTileDidMovedTo:(CGPoint)tilePoint {
    // You can add some cool sound effects here
    NSLog(@"Tile moved, add Sounds or something");
    step += 1;
    self.labelNumOfMoves.text = [NSString stringWithFormat:@"%d",step];
}

#pragma mark - Buttons Pressed
- (IBAction)buttonInfoPressed:(id)sender {
    BOOL useCustomView = NO;
    
    RNBlurModalView *modal;
    if (useCustomView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = 5.f;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = 5.f;
        
        modal = [[RNBlurModalView alloc] initWithViewController:self view:view];
    }
    else {
        NSString *localizedInstruction = [NSString stringWithFormat:@"1. %@\n2. %@\n3. %@",NSLocalizedString(@"Double tap to rotate", @""), NSLocalizedString(@"Long press to view image", @""), NSLocalizedString(@"Pinch to Zoom", @"Pinch to Zoom")];
        modal = [[RNBlurModalView alloc] initWithViewController:self title: NSLocalizedString(@"Instructions", "@") message:localizedInstruction];
    }
    [modal show];
}


- (IBAction)showPictureDown:(id)sender {
    //Button Touched
    self.imageViewShowPicture.hidden = NO;
    [Animations fadeIn:self.imageViewShowPicture andAnimationDuration:0.5 andWait:NO];
    self.board.hidden = YES;
}

- (IBAction)showPictureInside:(id)sender {
    //Touch of the button removed
    [Animations fadeOut:self.imageViewShowPicture andAnimationDuration:0.25 andWait:YES];
    self.board.hidden = NO;
    [Animations fadeIn:self.board andAnimationDuration:0.25 andWait:NO];
    self.imageViewShowPicture.hidden = YES;

}
@end
