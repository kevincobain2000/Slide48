//
//  TapToChooseMoreController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/21/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SEFilterControl.h"
#import "SharedData.h"
#import <AVFoundation/AVFoundation.h>

@interface TapToChooseMoreController : UIViewController{
    SEFilterControl *filter;
    SharedData *sharedData;
    AVAudioPlayer *audioPlayerButtonPress;
    AVAudioPlayer *audioPlayerCharm;
}

- (IBAction)buttonStartPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)buttonTapToChoosePressed:(id)sender;
- (IBAction)buttonBackPressed:(id)sender;


@end
