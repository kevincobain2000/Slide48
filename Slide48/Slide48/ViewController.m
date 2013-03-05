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
@synthesize puzzleCompleteImage;
@synthesize coinview;
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    
    //PUZZLE COMPLETE Life Starts
    puzzleCompleteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PuzzleComplete_iPhone"]];
    puzzleCompleteImage.center = CGPointMake(self.view.center.x, self.view.center.y-30);
    [self.view addSubview:puzzleCompleteImage];
    
    //Audio Players
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Applause-faded" ofType:@"mp3"]];
    audioPlayerGameFinished = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;
    [audioPlayerGameFinished prepareToPlay];
    
    NSURL *url_2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Button" ofType:@"wav"]];
    audioPlayerButtonPress = [[AVAudioPlayer alloc] initWithContentsOfURL:url_2 error:nil] ;
    [audioPlayerButtonPress prepareToPlay];
    
    NSURL *url_3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jump" ofType:@"wav"]];
    audioPlayerTileMoved = [[AVAudioPlayer alloc] initWithContentsOfURL:url_3 error:nil] ;
    [audioPlayerTileMoved prepareToPlay];

    //Puzzle COMPLETE Block Finish
    
    
    
    puzzleCompleteImage.alpha = 0;
    NSLog(@"View Did Load ViewController.m");
    //Initialize the Shared Data
    sharedData = [SharedData sharedData];
    
    //-----------------------------------------------------
    //HERE IT WILL GO THE LAST SAVED GAME
    //-----------------------------------------------------
     if (![sharedData.imagePathFromPuzzleLib isEqualToString:@""] && [sharedData.sharedBool boolValue] == YES) {
         
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
    NSLog(@"Difficulty level to start play %d",[sharedData.difficultyLevel intValue]);
    [board playWithImage:gambar andSize:([sharedData.difficultyLevel intValue]+2)];
    //-----------------------------------------------------
    //GAME HAS STARTED PLAYING
    //-----------------------------------------------------
    
    
}

- (void)viewDidUnload {
    [self setBoard:nil];
    [self setLabelNumOfMoves:nil];
    [self setImageViewShowPicture:nil];
    [self setViewPuzzleScoreOutlet:nil];
    [self setLabelFinalNumOfMoves:nil];
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
    [self showPuzzleCompleted];
}


- (void)puzzleBoard:(IAPuzzleBoardView *)board emptyTileDidMovedTo:(CGPoint)tilePoint {
    // You can add some cool sound effects here
    NSLog(@"Tile moved");
    [audioPlayerTileMoved play];
    step += 1;
    self.labelNumOfMoves.text = [NSString stringWithFormat:@"%d",step];
}

#pragma mark - Animations
-(void) showPuzzleCompleted{
    //Start the Coin View
    coinview = [[coinView alloc]initWithFrame:[self.viewPuzzleScoreOutlet bounds] withNum:9000];
    [self.viewPuzzleScoreOutlet addSubview:coinview];
    //Move to Audio
    
    //Audio Plays
    [audioPlayerGameFinished play];
    
    //Pulse Animation for the BIG HEART
    [UIView animateWithDuration:1 animations:^{
        
        puzzleCompleteImage.alpha = 1;
    }];
    
    puzzleCompleteImage.transform = CGAffineTransformScale(puzzleCompleteImage.transform, 1/1.8, 1/1.8);
    [UIView beginAnimations:@"pulseAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationRepeatCount:3.5];
    [UIView setAnimationDelegate:self];
    
    puzzleCompleteImage.transform = CGAffineTransformScale(puzzleCompleteImage.transform, 1.8, 1.8);
    
    [UIView commitAnimations];
    [Animations moveUp:self.puzzleCompleteImage andAnimationDuration:1.0 andWait:NO andLength:140];
    //First Animation Finish
    
    //Drop the Final SCore view from the Top
    //First is the PULSE ANIMATION
    self.viewPuzzleScoreOutlet.layer.cornerRadius = 5.0;
    self.viewPuzzleScoreOutlet.hidden = NO;
    self.labelFinalNumOfMoves.text = [NSString stringWithFormat:@"%d",step];
    [UIView animateWithDuration:1 animations:^{
        
        self.viewPuzzleScoreOutlet.alpha = 1;
    }];
    
    self.viewPuzzleScoreOutlet.transform = CGAffineTransformScale(self.viewPuzzleScoreOutlet.transform, 1/1.8, 1/1.8);
    [UIView beginAnimations:@"pulseAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationRepeatCount:2.5];
    [UIView setAnimationDelegate:self];
    
    self.viewPuzzleScoreOutlet.transform = CGAffineTransformScale(self.viewPuzzleScoreOutlet.transform, 1.8, 1.8);
    
    [UIView commitAnimations];
    //Pulse Animation finish and then do the drop
    //Note that both animations don't wait for each other
    
    float dropHeight = 260;
    if (IsRunningTallPhone()){
        dropHeight = 300;
    }
    else if (IsRunningiPad()){
        //Set the dropHeight
    }
    self.viewPuzzleScoreOutlet.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    [Animations frameAndShadow:self.viewPuzzleScoreOutlet andFrameColor:[UIColor yellowColor]];
    [Animations moveDown:self.viewPuzzleScoreOutlet andAnimationDuration:0.75 andWait:NO andLength:dropHeight];
    //Drop Done
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
- (IBAction)buttonMenuPressed:(id)sender {
    [audioPlayerButtonPress play];
}

#pragma mark coindelegate
-(void)coinAnimationFinished
{
    NSLog(@"Removing Coind View");
    [coinview removeFromSuperview];
    coinview = nil;
}
@end
