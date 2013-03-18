//
//  MenuViewController.m
//  Slide48
//
//  Created by Pulkit Kathuria on 2/26/13.
//  Copyright (c) 2013 Pulkit Kathuria. All rights reserved.
//

#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Initialize the Shared Data
    sharedData = [SharedData sharedData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyB.png"]];
    self.viewPopUp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    self.viewPopUp.layer.cornerRadius = 12;
    self.viewPopUp.layer.shadowOpacity = 0.7;
    self.viewPopUp.layer.shadowOffset = CGSizeMake(6, 6);
    self.viewPopUp.layer.shouldRasterize = YES;
    self.viewPopUp.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
	// Do any additional setup after loading the view.
    //Audio Players
    NSURL *url_2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Button" ofType:@"wav"]];
    audioPlayerButtonPress = [[AVAudioPlayer alloc] initWithContentsOfURL:url_2 error:nil] ;
    [audioPlayerButtonPress prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonStartPressed:(id)sender {
    [audioPlayerButtonPress play];
    sharedData.willPlayNewGame = [NSNumber numberWithBool:YES];
    
    
}
- (void)viewDidUnload {
    [self setViewPopUp:nil];
    [super viewDidUnload];
}
- (IBAction)buttonResumePressed:(id)sender {
    [audioPlayerButtonPress play];
}

- (IBAction)buttonLoadPressed:(id)sender {
    [audioPlayerButtonPress play];
}


@end
