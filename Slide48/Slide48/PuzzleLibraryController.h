//
//  PuzzleLibraryController.h
//  Slide48
//
//  Created by Pulkit Kathuria on 2/21/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
@interface PuzzleLibraryController : UITableViewController  {
    
    NSArray *contents;
    SharedData *sharedData;
    NSArray *thumbs;
    NSArray *paths;
}



@end


@interface PhotoCell : UITableViewCell {
    
}

@property (nonatomic, strong) UIImageView *photo;

@end