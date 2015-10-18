//
//  FPWNavigationController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/17/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWNavigationController.h"

@interface FPWNavigationController ()

@end

@implementation FPWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];

    // Set app title
    self.title = @"Foldy Paper Wallet";
    [self.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                 [UIFont fontWithName:@"Helvetica"
                                                                 size:14.0f],
                                       NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
