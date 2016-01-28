//
//  FPWWallet.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/13/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWWallet.h"
#import "UIImage+MDQRCode.h"
#import "NSData+BTCData.h"
#import <QuartzCore/QuartzCore.h>

@interface FPWWallet ( )

@property (nonatomic, strong) BTCKey *key;
@property (nonatomic, readwrite) BTCPublicKeyAddress *keyPublic;
@property (nonatomic, readwrite) BTCPrivateKeyAddress *keyPrivate;

@end

@implementation FPWWallet

- (instancetype)initWithKey:(BTCKey *)key
{
    if (self) {
        _key = key;
        _keyPrivate = key.privateKeyAddress;
        _keyPublic = key.address;
    }
    return self;
}

- (BTCPrivateKeyAddress *)makeRandomKey
{
    NSString *secretExponent = BTCRandomDataWithLength(32).SHA256.hex;
    BTCPrivateKeyAddress *randomKey = [BTCPrivateKeyAddress addressWithData:BTCDataFromHex(secretExponent)];
    return randomKey;
}

- (NSString*)addSpaceto:(NSString*)originalString afterWithGroupSize:(int)groupSize
{
    NSMutableString *result = [[NSMutableString alloc]initWithCapacity:originalString.length];
    
    for (int i=0;i<originalString.length;i++){
        [result appendString:[originalString substringWithRange:NSMakeRange(i,1)]];
        if (i>0 && (i+1) % groupSize==0){
            [result appendString:@" "];
        }
        
    }
    return [NSString stringWithString:result];
}

- (void)dumpKey:(BTCKey *)key
{
    NSLog(@"\n Private = %@", self.keyPrivate);
    NSLog(@"\n Public  = %@", self.keyPublic);
    NSLog(@"-----------------------------------------------------------");
}

@end