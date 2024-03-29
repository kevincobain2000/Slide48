//
//  ViewController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/14/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPuzzleBoardView.h"
#import "SharedData.h"
#import <AVFoundation/AVFoundation.h>
#import "coinView.h"

@interface ViewController : UIViewController <IAPuzzleBoardDelegate, coinViewDelegate>{
    UIImage *gambar;
    IAPuzzleBoardView *board;
    NSInteger step;
    
    SharedData *sharedData;
    
    AVAudioPlayer *audioPlayerGameFinished;
    AVAudioPlayer *audioPlayerButtonPress;
    AVAudioPlayer *audioPlayerTileMoved;


}
@property (strong, nonatomic) coinView *coinview;
@property (strong, nonatomic) IBOutlet IAPuzzleBoardView *board;
@property (strong, nonatomic) IBOutlet UILabel *labelNumOfMoves;

- (IBAction)buttonInfoPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewShowPicture;


//For more info on these actions see the referencing section
- (IBAction)showPictureDown:(id)sender;//THIS IS TouchDown
- (IBAction)showPictureInside:(id)sender;//THIS IS TouchUpInside
- (IBAction)buttonMenuPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewPuzzleScoreOutlet;


@property (nonatomic, strong) IBOutlet UIImageView *puzzleCompleteImage;
@property (strong, nonatomic) IBOutlet UILabel *labelFinalNumOfMoves;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEndGold;

@end
