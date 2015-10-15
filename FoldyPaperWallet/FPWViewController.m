//
//  FPWViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/15/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

//#import "FPWViewController.h"
//
//@interface FPWViewController ()
//
//@end
//
//@implementation FPWViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.wallets = [[NSMutableArray alloc] init];
//    
//    BTCKey *key = [[BTCKey alloc]init];
//    self.randomWallet = [[FPWWallet alloc] initWithKey:key name:@"Your choice.."];
//    [self.wallets addObject:self.randomWallet];
//    
//    [self updateScreenWithWallet:self.randomWallet];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//// Generate Random Key
//-(BTCPrivateKeyAddress *)makeRandomKey {
//    NSString *secretExponent = BTCRandomDataWithLength(32).SHA256.hex;
//    BTCPrivateKeyAddress *randomKey = [BTCPrivateKeyAddress addressWithData:BTCDataFromHex(secretExponent)];
//    return randomKey;
//}
//
//
//-(void)updateScreenWithWallet:(FPWWallet *)randomWallet{
//
//    for (NSUInteger i = 0; i< self.wallets.count; i++) {
//        FPWWallet *wallet = self.wallets[i];
//        
//        self.keyName.text = wallet.keyName;
//        self.keyPublicImage.image = [UIImage mdQRCodeForString:wallet.keyPublic.base58String
//                                                          size:self.keyPublicImage.bounds.size.width
//                                                     fillColor:[UIColor darkGrayColor]];
//        self.keyAddress.text = wallet.keyPublic.base58String;
//        self.keyPrivateImage.image = [UIImage mdQRCodeForString:wallet.keyPrivate.base58String
//                                                           size:self.keyPrivateImage.bounds.size.width
//                                                      fillColor:[UIColor darkGrayColor]];
//    }
//}
//
//
//
//@end
