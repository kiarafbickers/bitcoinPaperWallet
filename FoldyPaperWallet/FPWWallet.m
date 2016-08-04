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

@property (nonatomic, strong) NSData *seed;
@property (nonatomic, strong) BTCMnemonic *mneonic;
@property (nonatomic, strong) BTCKeychain *keychain;

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

- (instancetype)initRootHDWallet
{
    if (self)
    {
        NSData *seed = BTCRandomDataWithLength(32);
        _mneonic = [[BTCMnemonic alloc] initWithEntropy:seed password:@"1234" wordListType:BTCMnemonicWordListTypeEnglish];
        _seed = self.mneonic.seed;
        _keychain = [[BTCKeychain alloc] initWithSeed:self.mneonic.seed];
        
        
        NSMutableString *mneonicStringm = [NSMutableString new];
        for (NSString *word in _mneonic.words) {
            [mneonicStringm appendString:word];
            [mneonicStringm appendString:@" "];
        }
        
        _mnemonicString = mneonicStringm;
        NSLog(@"%@", _mnemonicString);
        
        _key = _keychain.key;
        _keyPublic = _key.address;
        _keyPrivate = _key.privateKeyAddress;
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