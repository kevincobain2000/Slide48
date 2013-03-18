//
//  MenuViewController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/26/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SharedData.h"
@interface MenuViewController : UIViewController{
    AVAudioPlayer *audioPlayerButtonPress;
    SharedData *sharedData;
}



@property (strong, nonatomic) IBOutlet UIView *viewPopUp;

- (IBAction)buttonStartPressed:(id)sender;
- (IBAction)buttonResumePressed:(id)sender;
- (IBAction)buttonLoadPressed:(id)sender;


@end
