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
        NSLog(@"%@",sharedData.imagePathFromPuzzleLib);
    }
    else{
        
    }
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonPress" ofType:@"wav"]];
    audioPlayerCharm = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;
    [audioPlayerCharm prepareToPlay];
    
    if ([sharedData.shouldPlayAudio boolValue] == YES){
        [audioPlayerCharm play];
        sharedData.shouldPlayAudio = [NSNumber numberWithBool:NO];
    }
}
- (void)viewDidLoad

{
    [super viewDidLoad];
    NSLog(@"View Did load Taptochoosemore");
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    
    //AudioPlayers
    
    
    NSURL *url_2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Button" ofType:@"wav"]];
    audioPlayerButtonPress = [[AVAudioPlayer alloc] initWithContentsOfURL:url_2 error:nil] ;
    [audioPlayerButtonPress prepareToPlay];
    
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
    float yAxisFilter = 300; //Position of SEFilter easy, medium, hard
    
    if (IsRunningTallPhone()){
        yAxisFilter = 360;
    }
    else if (IsRunningiPad()){
        //MAKE CHANGE
        //set the yAxis for iPad
        NSLog(@"is running ipad");
        yAxisFilter = 340;
    }
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, yAxisFilter, 300, 70) Titles:[NSArray arrayWithObjects:NSLocalizedString(@"Easy", @"Easy"), NSLocalizedString(@"Medium", @"Medium"), NSLocalizedString(@"Hard", @"Hard"), nil]];
    sharedData.difficultyLevel = [NSNumber numberWithInt:0];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [filter setHandlerColor:[UIColor yellowColor]];
    [filter setProgressColor:[UIColor magentaColor]];
    [filter setTitlesFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:14]];
    [self.view addSubview:filter];
}
#pragma mark - Slider delegate method
-(void)filterValueChanged:(SEFilterControl *) sender{
    NSLog(@"Changing difficulty level %d", sender.SelectedIndex);
    [audioPlayerButtonPress play];
    sharedData.difficultyLevel = [NSNumber numberWithInt:sender.SelectedIndex];

}

#pragma mark - Buttons Pressed
- (IBAction)buttonStartPressed:(id)sender {
    [audioPlayerButtonPress play];
    sharedData.sharedBool = [NSNumber numberWithBool:YES];
    
}
- (void)viewDidUnload {
    
    [self setImageView:nil];
    [super viewDidUnload];
}
- (IBAction)buttonTapToChoosePressed:(id)sender {
    [audioPlayerButtonPress play];
}

- (IBAction)buttonBackPressed:(id)sender {
    [audioPlayerButtonPress play];
}
@end
