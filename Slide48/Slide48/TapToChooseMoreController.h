//
//  TapToChooseMoreController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/21/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPuzzleBoardView.h"
#import "SEFilterControl.h"
#import "SharedData.h"

@interface TapToChooseMoreController : UIViewController{
    SEFilterControl *filter;
    SharedData *sharedData;
}

- (IBAction)buttonStartPressed:(id)sender;
@end
