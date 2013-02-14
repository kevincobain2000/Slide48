//
//  ViewController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/14/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPuzzleBoardView.h"
#import "SEFilterControl.h"
#import "SharedData.h"

@interface ViewController : UIViewController <IAPuzzleBoardDelegate>{
    UIImage *gambar;
    IAPuzzleBoardView *board;
    UIButton *startButton;
    NSInteger step;
    SEFilterControl *filter;
    SharedData *sharedData;
    int difficultyLevel;
}
@property (strong, nonatomic) IBOutlet IAPuzzleBoardView *board;


- (IBAction)start:(id)sender;

@end
