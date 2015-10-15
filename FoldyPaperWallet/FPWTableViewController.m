//
//  FPWTableViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewController.h"

@interface FPWTableViewController ()

@end

@implementation FPWTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.wallets = [[NSMutableArray alloc] init];
    
    BTCKey *key = [[BTCKey alloc]init];
    self.randomWallet = [[FPWWallet alloc] initWithKey:key name:@"Your choice.."];
    
    [self.wallets addObject:self.randomWallet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.wallets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneWalletCell" forIndexPath:indexPath];
    
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    
    UILabel *walletNameLabel = (UILabel *)[cell viewWithTag:100];
    walletNameLabel.text = wallet.keyName;
    
    UIImageView *publicKeyImage = (UIImageView *)[cell viewWithTag:101];
    publicKeyImage.image = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
                                                size:publicKeyImage.bounds.size.width
                                           fillColor:[UIColor darkGrayColor]];
    
    UILabel *walletAddressLabel = (UILabel *)[cell viewWithTag:102];
    walletAddressLabel.text = wallet.keyPublic.base58String;
    
    UIImageView *privateKeyImage = (UIImageView *)[cell viewWithTag:103];
    privateKeyImage.image = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
                                                      size:privateKeyImage.bounds.size.width
                                                 fillColor:[UIColor darkGrayColor]];
    
    return cell;
}




@end
