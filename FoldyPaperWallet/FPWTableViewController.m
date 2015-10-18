//
//  FPWTableViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewController.h"


@interface FPWTableViewController ()

@property (nonatomic,strong) FPWTableViewCell *tableCell;

@end

@implementation FPWTableViewController
@class FPWTableViewCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *planeImage = [UIImage imageNamed:@"plane.png"];
    self.myImageView = [[UIImageView alloc] initWithImage:planeImage];
    self.myImageView.tag = 99;
    
    CGRect myFrame = CGRectMake(100.0f, 168.0f, self.myImageView.frame.size.width * 0.6f,
                                                self.myImageView.frame.size.height * 0.6f);
    [self.myImageView setFrame:myFrame];
    [self.myImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.myImageView];
    
    self.tableView.allowsSelection = NO;
    
    // Initialize the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.0];
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
    NSLog(@"Bye!");
    
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
            
            UISimpleTextPrintFormatter *simpleText = [[UISimpleTextPrintFormatter alloc] initWithText:@"Air Print"];
            
            FPWPrintPageRenderer *pageRenderer = [[FPWPrintPageRenderer alloc] init];
            pageRenderer.printData = [[NSMutableDictionary alloc] init];
            
            FPWWallet *wallet = [self.wallets objectAtIndex:0];
            
            /*
             Need access to TableViewCell class labels
             But that would cause a circular dependency
             How do I forward deceration?
             */
            
            pageRenderer.printData = @{ @"keyPublicImage": wallet.keyPublicImage};
            
            // Need TableViewCell.keyPrivate.text 
            // @"walletName": wallet.keyPrivate
            // @"keyPublic" : wallet.keyPublic,
            
            pageRenderer.headerHeight = 72.0 / 2;
            pageRenderer.footerHeight = 72.0 / 2;
            [pageRenderer addPrintFormatter:simpleText startingAtPageAtIndex:0];
            
            pic.printPageRenderer = pageRenderer;
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
