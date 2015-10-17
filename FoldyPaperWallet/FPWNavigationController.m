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
    
    self.title = @"Foldy Paper Wallet";
    [self.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                 [UIFont fontWithName:@"Helvetica-Light"
                                                                 size:30.0f],
                                       NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
