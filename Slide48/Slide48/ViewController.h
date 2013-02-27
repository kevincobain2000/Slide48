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

@interface ViewController : UIViewController <IAPuzzleBoardDelegate>{
    UIImage *gambar;
    IAPuzzleBoardView *board;
    NSInteger step;
    
    SharedData *sharedData;
    
    AVAudioPlayer *audioPlayerGameFinished;

}
@property (strong, nonatomic) IBOutlet IAPuzzleBoardView *board;
@property (strong, nonatomic) IBOutlet UILabel *labelNumOfMoves;

- (IBAction)buttonInfoPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewShowPicture;


//For more info on these actions see the referencing section
- (IBAction)showPictureDown:(id)sender;//THIS IS TouchDown
- (IBAction)showPictureInside:(id)sender;//THIS IS TouchUpInside


@property (nonatomic, strong) IBOutlet UIImageView *puzzleCompleteImage;





@end
