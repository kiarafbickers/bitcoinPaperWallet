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
    [self generateNewWallet];
    
    self.tableView.allowsSelection = NO;
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}
- (void)reloadData {
    if (self.refreshControl) {
        // Attributes Title is buggy..
        // self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Generating wallet..."];
        [self generateNewWallet];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}
- (void) generateNewWallet {
    
    self.wallets = [[NSMutableArray alloc] init];
    BTCKey *key = [[BTCKey alloc]init];
    self.randomWallet = [[FPWWallet alloc] initWithKey:key name:@"Wallet Name"];
    [self.wallets addObject:self.randomWallet];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
// delegation pattern
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wallets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    
    cell.walletName.text = wallet.keyName;
    cell.keyPublicImage.image = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
                                                      size:cell.keyPublicImage.bounds.size.width
                                                 fillColor:[UIColor blackColor]];
    cell.keyAddress.text = wallet.keyPublic.base58String;
    cell.keyPrivateImage.image = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
                                                       size:cell.keyPrivateImage.bounds.size.width
                                                  fillColor:[UIColor blackColor]];
    return cell;
}
// Allow cell to be copied!
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return action == @selector(copy:);
}
-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    [UIPasteboard generalPasteboard].string = wallet.keyPublic.base58String;
}

// Enable air print
- (IBAction)tapToPrint:(id)sender {
}


@end
