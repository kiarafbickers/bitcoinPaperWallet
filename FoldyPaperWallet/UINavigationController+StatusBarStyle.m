//
//  UINavigationController+StatusBarStyle.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/21/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"
#import "FPWTableViewController.h"

@interface UINavigationController_StatusBarStyle ()

@end

@implementation UINavigationController_StatusBarStyle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([self.title isEqualToString:@"Foldy Paper Wallet"]) {
        // Make Navigation controller white
        self.navigationBar.backgroundColor = [UIColor whiteColor];
        self.navigationBar.translucent = NO;
        return UIStatusBarStyleDefault;
    }
    else if ([self.title isEqualToString:@"Pull To Generate"]) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
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
