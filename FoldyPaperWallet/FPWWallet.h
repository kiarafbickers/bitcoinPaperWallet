//
//  FPWWallet.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBitcoin/CoreBitcoin.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+MDQRCode.h"
#import "NSData+BTCData.h"

@interface FPWWallet : NSObject

@property (nonatomic, strong) BTCKey *key;
@property (nonatomic, strong) NSString *keyName;
@property (nonatomic, readonly) BTCPublicKeyAddress *keyPublic;
@property (nonatomic, strong) UIImage *keyPublicImage;
@property (nonatomic, readonly) BTCPrivateKeyAddress *keyPrivate;
@property (nonatomic, strong) UIImage *keyPrivateImage;

@property (nonatomic, strong) UIImage *keyImage;

- (int)getRandomNumberBetween:(int)from to:(int)to;
// CALL: int randomNumber = [self getRandomNumberBetween:9 to:99];

- (instancetype)initWithKey:(BTCKey *)key
                       name:(NSString *)keyName;


@end
