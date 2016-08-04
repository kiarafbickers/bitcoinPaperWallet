//
//  FPWTableViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewController.h"
#import "FPWTableViewCell.h"
#import "UIImage+MDQRCode.h"
#import <QuartzCore/QuartzCore.h>
#import <UIAlertController+Blocks/UIAlertController+Blocks.h>
@class FPWTableViewCell;

#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getClearImage];
    [self setGradient];
    [self setGenerateScreen];
    [self placeGradientBackround];
    [self.blend removeFromSuperlayer];
    [self setRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
}

- (void)generateNewWallet
{
    self.wallets = [[NSMutableArray alloc] init];
    BTCKey *key = [[BTCKey alloc]init];
    self.randomWallet = [[FPWWallet alloc] initWithKey:key];
    [self.wallets addObject:self.randomWallet];
    [self removeLoadImage];
}

- (void)setGenerateScreen
{
    [self setInitialNavigationBar];
    
    UIImage *planeImage = [UIImage imageNamed:@"plane.png"];
    self.myImageView = [[UIImageView alloc] initWithImage:planeImage];
    self.myImageView.tag = 99;

    if(isiPhone) {
        if (isiPhone5) {
            CGRect myFrame = CGRectMake(87.0f, 168.0f, self.myImageView.frame.size.width * 0.6f,
                                        self.myImageView.frame.size.height * 0.6f);
            [self.myImageView setFrame:myFrame];
        }
        else if (isiPhone6) {
            CGRect myFrame = CGRectMake(115.0f, 168.0f, self.myImageView.frame.size.width * 0.6f,
                                        self.myImageView.frame.size.height * 0.6f);
            [self.myImageView setFrame:myFrame];
        }
        else if (isiPhone6Plus) {
            CGRect myFrame = CGRectMake(127.0f, 168.0f, self.myImageView.frame.size.width * 0.7f,
                                        self.myImageView.frame.size.height * 0.7f);
            [self.myImageView setFrame:myFrame];
        }
        else {
            CGRect myFrame = CGRectMake(97.0f, 110.0f, self.myImageView.frame.size.width * 0.5f,
                                        self.myImageView.frame.size.height * 0.5f);
            [self.myImageView setFrame:myFrame];
        }
    }
    
    [self.myImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.myImageView];
}
- (void)setInitialNavigationBar
{
    self.title = @"Pull To Generate";
    self.printButton.hidden = YES;
    self.backButton.hidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                                           [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                           size:16.0f],
                                                                       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)setMainNavigationBar
{
    self.title = @"Foldy Paper Wallet";
    self.printButton.hidden = NO;
    self.backButton.hidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f],NSForegroundColorAttributeName:[UIColor blackColor]}];

}
- (void)setGradient
{
    UIColor *darkBlue = [UIColor colorWithRed:0.11 green:0.47 blue:0.94 alpha:1.0];
    UIColor *lightBlue = [UIColor colorWithRed:0.51 green:0.95 blue:0.99 alpha:1.0];

    NSArray *colors = @[ (id)darkBlue.CGColor, (id)lightBlue.CGColor];
    self.blend = [[CAGradientLayer alloc]init];
    self.blend.startPoint = CGPointMake(0.5, 0);
    self.blend.endPoint = CGPointMake(0.5, 1);
    self.blend.colors = colors;

    [self.view.layer insertSublayer:self.blend atIndex:0];
    self.blend.frame = self.view.bounds;
    
    [self getGradientImage];
}

- (UIImage *)getGradientImage
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set]; CGContextFillRect(ctx, screenRect);
    [self.view.layer renderInContext:ctx];
    self.gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return self.gradientImage;
}

- (void)placeGradientBackround
{
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:self.gradientImage];
}

- (UIImage *)getClearImage
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set]; CGContextFillRect(ctx, screenRect);
    [self.view.layer renderInContext:ctx];
    self.gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return self.clearImage;
}

- (void)placeClearBackround
{
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:self.clearImage];
}

- (void)setRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)reloadData
{
    if (self.refreshControl) {
        [self generateNewWallet];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}

- (void)removeLoadImage
{
    UIView *viewToRemove = [self.view viewWithTag:99];
    [viewToRemove removeFromSuperview];
}

- (void)pushWarningScreen
{
    NSString *warningMessage = @"DO NOT let anyone see your private key or they can spend your bitcoins.\n\nDO NOT copy your private key to password managers or anywhere else. Paper wallets are intended for storing bitcoins offline, strictly as a physical document.\n\nThe bitcoin keys generated here are NOT PERMANENTLY STORED in this application.";
    
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"WARNING"
                                         message:warningMessage
                               cancelButtonTitle:@"Got it!"
                          destructiveButtonTitle:@"Cancel"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                            
                                            if (buttonIndex == controller.cancelButtonIndex) {

                                            }
                                            else if (buttonIndex == controller.destructiveButtonIndex) {
                                                [self cancelScreen];
                                            }
                                        }];
}

- (void)cancelScreen
{
    [self.wallets removeAllObjects];
    [self placeGradientBackround];
    
    [UIView transitionWithView:self.tableView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
         [self.tableView reloadData];
     }
                    completion:nil];
    [self setGenerateScreen];
}

- (void)checkIfFirstKey
{
    if (![self.title  isEqualToString: @"Foldy Paper Wallet"]) {
        [self placeClearBackround];
        [self setMainNavigationBar];
        [self pushWarningScreen];
    }
}

- (IBAction)tapToGoBack:(id)sender
{
    [self cancelScreen];
}

#pragma mark - Set custom table cell

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wallets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.allowsSelection = NO;
    
    FPWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    FPWWallet *wallet = [self.wallets objectAtIndex:indexPath.row];
    
    // PRIVATE KEY
    wallet.keyPrivateImage = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
                                                   size:cell.keyPrivateImage.bounds.size.width
                                              fillColor:[UIColor blackColor]];
    cell.keyPrivateImage.image = wallet.keyPrivateImage;
    cell.keyPrivateTextfield.text = wallet.keyPrivate.base58String;
    
    // PUBLIC KEY
    wallet.keyPublicImage = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
                                                      size:cell.keyPublicImage.bounds.size.width
                                                 fillColor:[UIColor blackColor]];
    cell.keyPublicImage.image = wallet.keyPublicImage;
    cell.keyPublicTextfield.text = wallet.keyPublic.base58String;

    [self checkIfFirstKey];
    return cell;
}

#pragma mark - Air print

- (IBAction)tapToPrint:(id)sender
{
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
