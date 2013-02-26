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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink-hearts.png"]];
    self.viewPopUp.layer.cornerRadius = 12;
    self.viewPopUp.layer.shadowOpacity = 0.7;
    self.viewPopUp.layer.shadowOffset = CGSizeMake(6, 6);
    self.viewPopUp.layer.shouldRasterize = YES;
    self.viewPopUp.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonStartPressed:(id)sender {
}
- (void)viewDidUnload {
    [self setViewPopUp:nil];
    [super viewDidUnload];
}
@end
