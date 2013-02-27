//
//  SharedData.h
//  temp
//
//  Created by Pulkit Kathuria on 11/20/12.
//  Copyright (c) 2012 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define IsRunningTallPhone() ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)

#define IsRunningiPad() ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height > 568)
#define RGBConvert (float) 255

@interface SharedData : UIView {
    

}
+(SharedData *) sharedData;

@property (strong, nonatomic) NSNumber *sharedBool;
@property (strong, nonatomic) NSNumber *difficultyLevel;
@property (strong, nonatomic) NSString *imagePathFromPuzzleLib;
@property (strong, nonatomic) NSNumber *shouldPlayAudio;
@end
