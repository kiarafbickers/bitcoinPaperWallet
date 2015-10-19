//
//  FPWTableViewController.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FPWWallet.h"
#import "FPWTableViewCell.h"

@interface FPWTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *wallets;
@property (nonatomic, strong) FPWWallet *randomWallet;
@property (nonatomic, strong) UIImageView *myImageView;

@end
