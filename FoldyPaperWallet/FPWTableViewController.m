//
//  FPWTableViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewController.h"

@interface FPWTableViewController ()

@property (nonatomic, strong) FPWTableViewCell *tableCell;
@property (weak, nonatomic) IBOutlet UIButton *printButton;
@property (nonatomic, strong) CAGradientLayer *blend;


@end

@implementation FPWTableViewController
@class FPWTableViewCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationController.navigationBarHidden = YES;
    self.printButton.hidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    
    self.title = @"Pull to generate..";
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                      [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                      size:14.0f],
                                                  NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIColor *darkBlue = [UIColor colorWithRed:0.11 green:0.47 blue:0.94 alpha:1.0];
    UIColor *lightBlue = [UIColor colorWithRed:0.51 green:0.95 blue:0.99 alpha:1.0];
    
    NSArray *colors = @[ (id)darkBlue.CGColor, (id)lightBlue.CGColor];
    self.blend = [[CAGradientLayer alloc]init];
    self.blend.startPoint = CGPointMake(0.5, 0);
    self.blend.endPoint = CGPointMake(0.5, 1);
    self.blend.colors = colors;
    
    [self.view.layer insertSublayer:self.blend atIndex:0];
    self.blend.frame = self.view.bounds;
    
    UIImage *planeImage = [UIImage imageNamed:@"plane.png"];
    self.myImageView = [[UIImageView alloc] initWithImage:planeImage];
    self.myImageView.tag = 99;
    
    CGRect myFrame = CGRectMake(100.0f, 168.0f, self.myImageView.frame.size.width * 0.6f,
                                                self.myImageView.frame.size.height * 0.6f);
    [self.myImageView setFrame:myFrame];
    [self.myImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.myImageView];
    
////  General Declarations
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    //// Picture Drawing
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, 1087.63, -236.4);
//    
//    UIBezierPath* picturePath = [UIBezierPath bezierPathWithRect: CGRectMake(-831.63, 361.4, 240, 168)];
//    CGContextSaveGState(context);
//    [picturePath addClip];
//    [planeImage drawInRect: CGRectMake(-832, 361, planeImage.size.width, planeImage.size.height)];
//    CGContextRestoreGState(context);
//    
//    CGContextRestoreGState(context);
//    
    self.tableView.allowsSelection = NO;
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.0];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.navigationBar.translucent = YES;
}


//- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"viewWillAppear");
//}
//- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"viewDidAppear");
//}
//- (void)viewDidDisappear:(BOOL)animated {
//    NSLog(@"viewDidDisappear");
//}
//- (void)viewDidUnload {
//    NSLog(@"viewDidUnload");
//}
//- (void)viewDidDispose {
//    NSLog(@"viewDidDispose");
//}

- (void)reloadData {
    if (self.refreshControl) {
        // Attributes Title is buggy..
        // self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Generating wallet..."];
        [self generateNewWallet];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}
- (void)generateNewWallet {
    
    self.wallets = [[NSMutableArray alloc] init];
    BTCKey *key = [[BTCKey alloc]init];
    self.randomWallet = [[FPWWallet alloc] initWithKey:key];
    [self.wallets addObject:self.randomWallet];
    [self removeLoadImage];
}
- (void)removeLoadImage {
    UIView *viewToRemove = [self.view viewWithTag:99];
    [viewToRemove removeFromSuperview];
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
    
    self.printButton.hidden = NO;
    
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
    NSLog(@"Table Cells Made!");
    
    self.title = @"Foldy Paper Wallet";
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:
                                                                           [UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                           size:14.0f],
                                                                       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    return cell;
}
// Allow cell to have "Copy" functionality
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

// Enable Air print
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
