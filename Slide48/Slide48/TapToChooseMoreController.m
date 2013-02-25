//
//  TapToChooseMoreController.m
//  Slide48
//
//  Created by Pulkit Kathuria on 2/21/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import "TapToChooseMoreController.h"

@interface TapToChooseMoreController ()

@end

@implementation TapToChooseMoreController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    sharedData = [SharedData sharedData];
    if (![sharedData.imagePathFromPuzzleLib isEqualToString:@""]) {
        [self.imageView setImage:[UIImage imageWithContentsOfFile:sharedData.imagePathFromPuzzleLib] ];
    }
    NSLog(@"%@",sharedData.imagePathFromPuzzleLib);
}
- (void)viewDidLoad

{
    [super viewDidLoad];
    NSLog(@"View Did load Taptochoosemore");
    
    

    
    [self difficultyLevel];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Slider Difficulty

-(void) difficultyLevel{
    
    NSLog(@"AutoSetting difficulty level = 0");
    float yAxisFilter = 260; //Position of SEFilter easy, medium, hard
    
    if (IsRunningTallPhone()){
        yAxisFilter = 340;
    }
    else if (IsRunningiPad()){
        //MAKE CHANGE
        //set the yAxis for iPad
        NSLog(@"is running ipad");
        yAxisFilter = 340;
    }
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, yAxisFilter, 300, 70) Titles:[NSArray arrayWithObjects:NSLocalizedString(@"Easy", @"Easy"), NSLocalizedString(@"Medium", @"Medium"), NSLocalizedString(@"Hard", @"Hard"), nil]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [filter setHandlerColor:[UIColor yellowColor]];
    [filter setProgressColor:[UIColor magentaColor]];
    [filter setTitlesFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:14]];
    [self.view addSubview:filter];
}
#pragma mark - Slider delegate method
-(void)filterValueChanged:(SEFilterControl *) sender{
    NSLog(@"Changing difficulty level %d", sender.SelectedIndex);
    sharedData.difficultyLevel = [NSNumber numberWithInt:sender.SelectedIndex];

}

- (IBAction)buttonStartPressed:(id)sender {
}
- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
