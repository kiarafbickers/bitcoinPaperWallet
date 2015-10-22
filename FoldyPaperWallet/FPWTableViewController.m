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
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, strong) CAGradientLayer *blend;
@property (nonatomic, strong) UIImage *gradientImage;
@property (nonatomic, strong) UIImage *clearImage;
@property (nonatomic) CGFloat lastOffset;

@end

@implementation FPWTableViewController
@class FPWTableViewCell;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // Set up view
    [self getClearImage];
    [self setGradient];
    [self setGenerateScreen];
    [self placeGradientBackround];
    
    // Remove gradient
    [self.blend removeFromSuperlayer];
    
    [self setRefreshControl];
}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
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
- (void) setInitialNavigationBar {
    
    // Set title, hide print button, and attributes
    self.title = @"Pull To Generate";
    self.printButton.hidden = YES;
    self.backButton.hidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                                           [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                           size:16.0f],
                                                                       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Make Navigation controller completely translucent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void) setMainNavigationBar {
    
    self.title = @"Foldy Paper Wallet";
    self.printButton.hidden = NO;
    self.backButton.hidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                                           [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                           size:16.0f],
                                                                       NSForegroundColorAttributeName:[UIColor blackColor]}];

}
- (void) setGradient {
    
    // Define top and bottom UIColors in gradient
    UIColor *darkBlue = [UIColor colorWithRed:0.11 green:0.47 blue:0.94 alpha:1.0];
    UIColor *lightBlue = [UIColor colorWithRed:0.51 green:0.95 blue:0.99 alpha:1.0];
    
    // Put colors into array
    NSArray *colors = @[ (id)darkBlue.CGColor, (id)lightBlue.CGColor];
    self.blend = [[CAGradientLayer alloc]init];
    self.blend.startPoint = CGPointMake(0.5, 0);
    self.blend.endPoint = CGPointMake(0.5, 1);
    self.blend.colors = colors;
    
    // Add gradient array to view layer
    [self.view.layer insertSublayer:self.blend atIndex:0];
    self.blend.frame = self.view.bounds;
    
    // Convert gradient to image
    [self getGradientImage];
}
- (UIImage *) getGradientImage {
    
    // Get the size of the screen
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // Create a bitmap-based graphics context and make it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set]; CGContextFillRect(ctx, screenRect);
    
    // Render the receiver and its sublayers into a view or use the window to get a screenshot of the entire device
    [self.view.layer renderInContext:ctx];
    self.gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    return self.gradientImage;
}
- (void) placeGradientBackround {
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:self.gradientImage];
}
- (UIImage *) getClearImage {
    
    //Get the size of the screen
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //Create a bitmap-based graphics context and make it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set]; CGContextFillRect(ctx, screenRect);
    
    // Render the receiver and its sublayers into the specified context choose a view or use the window to get a screenshot of the entire device
    [self.view.layer renderInContext:ctx];
    self.gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    return self.clearImage;
}
- (void) placeClearBackround {
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:self.clearImage];
}
- (void) setRefreshControl {
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}
- (void) reloadData {
    
    if (self.refreshControl) {
        [self generateNewWallet];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}
- (void) removeLoadImage {
    
    // Remove plane image
    UIView *viewToRemove = [self.view viewWithTag:99];
    [viewToRemove removeFromSuperview];
}
- (void) pushWarningScreen {
    
    // Set warning screen
    NSString *warningMessage = @"DO NOT let anyone see your private key or they can spend your bitcoins.\n\nDO NOT copy your private key to password managers or anywhere else. Paper wallets are intended for storing bitcoins offline, strictly as a physical document.\n\nThe bitcoin keys generated here are NOT STORED in this application outside of this screen.";
    
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"WARNING"
                                         message:warningMessage
                               cancelButtonTitle:@"Got it!"
                          destructiveButtonTitle:@"Cancel"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                            
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                NSLog(@"Okay Tapped");
                                            }
                                            else if (buttonIndex == controller.destructiveButtonIndex) {
                                                // [self placeClearBackround];
                                                [self cancelScreen];
                                                NSLog(@"Cancel Tapped");
                                            }
                                        }];
}
- (void) cancelScreen {

    [self.wallets removeAllObjects];
    [self placeGradientBackround];
    
    // Animate the table view reload
    // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [UIView transitionWithView:self.tableView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
         [self.tableView reloadData];
     }
                    completion:nil];
    [self setGenerateScreen];
}

#pragma mark - Set custom table cell
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wallets.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Disable cell selection
    self.tableView.allowsSelection = NO;
    
    FPWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    
    // PRIVATE KEY
    wallet.keyPrivateImage = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
                                                   size:cell.keyPrivateImage.bounds.size.width
                                              fillColor:[UIColor blackColor]];
    cell.keyPrivateImage.image = wallet.keyPrivateImage;
    
    // Split key into 2 lines
    NSUInteger middle = wallet.keyPrivate.base58String.length / 2;
    NSString *firstHalf = [wallet.keyPrivate.base58String substringToIndex:middle];
    NSString *secondHalf = [wallet.keyPrivate.base58String substringFromIndex:middle];
    NSString *privateLabel = [NSString stringWithFormat:@"%@\n%@", firstHalf, secondHalf];
    cell.keyPrivateAddress.text = privateLabel;
    
    
    // PUBLIC KEY
    wallet.keyPublicImage = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
                                                      size:cell.keyPublicImage.bounds.size.width
                                                 fillColor:[UIColor blackColor]];
    cell.keyPublicImage.image = wallet.keyPublicImage;
    cell.keyAddress.text = wallet.keyPublic.base58String;

    [self checkIfFirstKey];
    return cell;
}
- (void) checkIfFirstKey {
    
    if (![self.title  isEqualToString: @"Foldy Paper Wallet"]) {
        [self placeClearBackround];
        [self setMainNavigationBar];
        [self pushWarningScreen];
    }
}


- (IBAction)tapToGoBack:(id)sender {
    [self cancelScreen];
}

#pragma mark - Air print
- (IBAction) tapToPrint:(id)sender {
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
