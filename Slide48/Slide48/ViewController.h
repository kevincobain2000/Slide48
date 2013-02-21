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

@interface ViewController : UIViewController <IAPuzzleBoardDelegate>{
    UIImage *gambar;
    IAPuzzleBoardView *board;
    NSInteger step;

    SharedData *sharedData;

}
@property (strong, nonatomic) IBOutlet IAPuzzleBoardView *board;

@property (strong, nonatomic) IBOutlet UIView *popupView; //This is hidden initially


- (IBAction)buttonMenuPressed:(id)sender;
- (IBAction)buttonResumePressed:(id)sender;
- (IBAction)buttonStartNewPressed:(id)sender;
- (IBAction)buttonLoadPressed:(id)sender;


@end
