//
//  FPWWallet.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBitcoin/CoreBitcoin.h>

@interface FPWWallet : NSObject

@property (nonatomic, readonly) BTCPublicKeyAddress *keyPublic;
@property (nonatomic, strong)   UIImage *keyPublicImage;
@property (nonatomic, readonly) BTCPrivateKeyAddress *keyPrivate;
@property (nonatomic, strong)   UIImage *keyPrivateImage;
@property (nonatomic, strong) NSString *mnemonicString;
@property (nonatomic, readonly) NSData *seed;

- (instancetype)initWithKey:(BTCKey *)key;
- (instancetype)initRootHDWallet;

@end
