//
//  FPWTableViewController.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPWWallet.h"

@interface FPWTableViewController : UITableViewController

@property (nonatomic, strong) FPWWallet *wallet;
@property (nonatomic, strong) NSMutableArray *wallets;
@property (nonatomic, strong) UIImageView *myImageView;

@end
