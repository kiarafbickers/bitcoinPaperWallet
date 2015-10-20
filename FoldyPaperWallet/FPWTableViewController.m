//
//  FPWTableViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewController.h"
#import <UIAlertController+Blocks/UIAlertController+Blocks.h>

@interface FPWTableViewController ()

@property (nonatomic, strong) FPWTableViewCell *tableCell;
@property (weak, nonatomic) IBOutlet UIButton *printButton;
@property (nonatomic, strong) CAGradientLayer *blend;

@end

@implementation FPWTableViewController
@class FPWTableViewCell;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setGenerateScreen];
    [self setRefreshControl];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)generateNewWallet {
    
    self.wallets = [[NSMutableArray alloc] init];
    BTCKey *key = [[BTCKey alloc]init];
    self.randomWallet = [[FPWWallet alloc] initWithKey:key];
    [self.wallets addObject:self.randomWallet];
    [self removeLoadImage];
}
- (void)setGenerateScreen {
    
    [self setInitialNavigationBar];
    [self setGradient];
    
    // Set logo image centered on view
    UIImage *planeImage = [UIImage imageNamed:@"plane.png"];
    self.myImageView = [[UIImageView alloc] initWithImage:planeImage];
    self.myImageView.tag = 99;
    CGRect myFrame = CGRectMake(100.0f, 168.0f, self.myImageView.frame.size.width * 0.6f,
                                self.myImageView.frame.size.height * 0.6f);
    [self.myImageView setFrame:myFrame];
    [self.myImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.myImageView];

}
- (void)setInitialNavigationBar {
    
    self.title = @"Pull to generate..";
    self.printButton.hidden = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                                      [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                      size:14.0f],
                                                            NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)setMainNavigationBar {
    
    self.title = @"Foldy Paper Wallet";
    self.printButton.hidden = NO;
}
- (void)setGradient{
    
    // Define top and bottom UIColors
    UIColor *darkBlue = [UIColor colorWithRed:0.11 green:0.47 blue:0.94 alpha:1.0];
    UIColor *lightBlue = [UIColor colorWithRed:0.51 green:0.95 blue:0.99 alpha:1.0];
    
    // Put into array
    NSArray *colors = @[ (id)darkBlue.CGColor, (id)lightBlue.CGColor];
    self.blend = [[CAGradientLayer alloc]init];
    self.blend.startPoint = CGPointMake(0.5, 0);
    self.blend.endPoint = CGPointMake(0.5, 1);
    self.blend.colors = colors;
    
    // Add gradient array to view layer
    [self.view.layer insertSublayer:self.blend atIndex:0];
    self.blend.frame = self.view.bounds;
}
- (void)setRefreshControl {
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.0];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}
- (void)pushWarningScreen {
    
    NSString *warningMessage = @"DO NOT let anyone see your private key or they can spend your bitcoins.\n\nDO NOT copy your private key to password managers or anywhere else. Paper wallets are intended for storing bitcoins offline, strictly as a physical document.\n\nThe bitcoin keys generated here are NEVER STORED in this application.";
    
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"WARNING"
                                         message:warningMessage
                               cancelButtonTitle:@"Okay"
                          destructiveButtonTitle:@"Cancel"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                            
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                NSLog(@"Okay Tapped");
                                            }
                                            else if (buttonIndex == controller.destructiveButtonIndex) {
                                                NSLog(@"Cancel Tapped");
                                            }
                                        }];
}
- (void)reloadData {
    
    if (self.refreshControl) {
        [self generateNewWallet];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}
- (void)removeLoadImage {
    
    UIView *viewToRemove = [self.view viewWithTag:99];
    [viewToRemove removeFromSuperview];
}

#pragma mark - Set custom table cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wallets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FPWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
        
    wallet.keyPublicImage = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
                                                      size:cell.keyPublicImage.bounds.size.width
                                                 fillColor:[UIColor blackColor]];
    cell.keyPublicImage.image = wallet.keyPublicImage;
    cell.keyAddress.text = wallet.keyPublic.base58String;
    wallet.keyPrivateImage = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
                                                       size:cell.keyPrivateImage.bounds.size.width
                                                  fillColor:[UIColor blackColor]];
    cell.keyPrivateImage.image = wallet.keyPrivateImage;

    [self checkIfFirstKey];
    return cell;
}
- (void) checkIfFirstKey {
    if (![self.title  isEqualToString: @"Foldy Paper Wallet"]) {
        [self setMainNavigationBar];
        [self pushWarningScreen];
    }
}
#pragma mark - Override for copy fuctionality
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    return action == @selector(copy:);
}
-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    [UIPasteboard generalPasteboard].string = wallet.keyPublic.base58String;
}

#pragma mark - Air print
- (IBAction)tapToPrint:(id)sender {
    {
        
        if ([UIPrintInteractionController isPrintingAvailable]) {
            UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
            
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = self.title;
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            printInfo.orientation = UIPrintInfoOrientationPortrait;
            pic.printInfo = printInfo;
            
            UITableViewCell *cell = self.tableView.visibleCells.firstObject;
            UIGraphicsBeginImageContext(cell.frame.size);
            [cell drawViewHierarchyInRect:cell.bounds afterScreenUpdates:NO];
            UIImage *cellImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            pic.printingItem = cellImage;
            
            pic.showsPageRange = YES;
            [pic presentAnimated:YES
               completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
                   
                   
                   if (!completed && (error != nil)) {
                       NSLog(@"Error Printing: %@", error);
                   }
                   else {
                       NSLog(@"Printing Cancelled");
                   }
            }];
        }
    }
}


@end
