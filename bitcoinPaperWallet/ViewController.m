//
//  ViewController.m
//  bitcoinPaperWallet
//
//  Created by Kiara Robles on 10/11/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+MDQRCode.h"
#import "NSData+BTCData.h"
#import <CoreBitcoin/CoreBitcoin.h>
#import <QuartzCore/QuartzCore.h>



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UIView *qrContainer;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    NSString *passphrase = @"The quick brown fox jumps over the lazy dog";
    //    BTCPrivateKeyAddress *key1 = [self keyFromPassphrase:passphrase];
    //    [self dumpKey:key1];
    
    
    //    NSString *secretExponent = BTCRandomDataWithLength(32).SHA256.hex;;
    //    BTCPrivateKeyAddress *key2 = [self keyFromExponent:secretExponent];
    //    [self dumpKey:key2];
    //    [self buildQR:key2];
    
    
    
    BTCPrivateKeyAddress *key = [self makeRandomKey];
    [self saveQRImages:key];
    
}
- (IBAction)generate:(id)sender {
    BTCPrivateKeyAddress *key = [self makeRandomKey];
    [self saveQRImages:key];
}




-(void)saveQRImages:(BTCPrivateKeyAddress*)key{
    int refnum =0;
    
    
    NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    
    //public
    self.keyLabel.text = [self addSpaceto:key.publicAddress.string  afterWithGroupSize:4] ;
    self.qrImageView.image = [UIImage mdQRCodeForString:key.publicAddress.string size:self.qrImageView.bounds.size.width fillColor:[UIColor blackColor]];
    
    NSString *publicfilename = [NSString stringWithFormat:@"public_%i.png",refnum];
    NSString *publicImagePath = [cachedFolderPath stringByAppendingPathComponent:publicfilename];
    
    UIImage *pub  = [self imageWithView:self.qrContainer];
    [UIImagePNGRepresentation(pub) writeToFile:publicImagePath atomically:YES];
    NSLog(@"Written to %@",publicImagePath);
    
    
    
    
    //private
    self.keyLabel.text = [self addSpaceto:key.string  afterWithGroupSize:4] ;
    self.qrImageView.image = [UIImage mdQRCodeForString:key.string size:self.qrImageView.bounds.size.width fillColor:[UIColor blackColor]];
    
    NSString *privateFilename = [NSString stringWithFormat:@"private_%i.png",refnum];
    NSString *privateImagePath = [cachedFolderPath stringByAppendingPathComponent:privateFilename];
    
    UIImage *priv  = [self imageWithView:self.qrContainer];
    [UIImagePNGRepresentation(priv) writeToFile:privateImagePath atomically:YES];
    NSLog(@"Written to %@",publicImagePath);
    
    
    
    
    //    NSString *privateKeyStringForDisplay = [self addSpaceto:key.string                afterWithGroupSize:4];
    //    self.privateKeyLabel.text = privateKeyStringForDisplay;
    //    self.privateImageView.image = [UIImage mdQRCodeForString:key.string size:100 fillColor:[UIColor blackColor]];
    //    NSString *privatefilename = [NSString stringWithFormat:@"private_%i.png",refnum];
    //    NSString *privateImagePath = [cachedFolderPath stringByAppendingPathComponent:privatefilename];
    //
    //    UIImage *pub  = [self imageWithView:self.publicView];
    //    UIImage *priv = [self imageWithView:self.privateView];
    //
    //    [UIImagePNGRepresentation(pub) writeToFile:publicImagePath atomically:YES];
    //    [UIImagePNGRepresentation(pub) writeToFile:privateImagePath atomically:YES];
    //
    //    NSLog(@"Written to %@",publicImagePath);
    //    NSLog(@"Written to %@",privateImagePath);
}



-(BTCPrivateKeyAddress*)makeRandomKey{
    NSString *secretExponent = BTCRandomDataWithLength(32).SHA256.hex;;
    BTCPrivateKeyAddress *randKey = [self keyFromExponent:secretExponent];
    return randKey;
    
}




- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}



-(NSString*)addSpaceto:(NSString*)originalString afterWithGroupSize:(int)groupSize{
    NSMutableString *result = [[NSMutableString alloc]initWithCapacity:originalString.length];
    
    for (int i=0;i<originalString.length;i++){
        [result appendString:[originalString substringWithRange:NSMakeRange(i,1)]];
        if (i>0 && (i+1) % groupSize==0){
            [result appendString:@" "];
        }
        
    }
    return [NSString stringWithString:result];
}


-(BTCPrivateKeyAddress*)keyFromExponent:(NSString*)secretExponent{
    NSString *secEx = secretExponent;
    NSLog(@"Secret Exponent %@",secEx);
    BTCPrivateKeyAddress* addr2 = [BTCPrivateKeyAddress addressWithData:BTCDataFromHex(secEx)];
    return addr2;
}

-(BTCPrivateKeyAddress*)keyFromPassphrase:(NSString*)passphrase{
    NSString *secEx = BTCDataWithUTF8CString([passphrase UTF8String]).SHA256.hex;
    NSLog(@"Secret Exponent %@",secEx);
    BTCPrivateKeyAddress* addr2 = [BTCPrivateKeyAddress addressWithData:BTCDataFromHex(secEx)];
    return addr2;
}

-(void)dumpKey:(BTCPrivateKeyAddress*)key{
    NSLog(@"Address = %@",[self addSpaceto:key.string  afterWithGroupSize:4]);
    NSLog(@"Address = %@",key.string);
    NSLog(@"Public  = %@",[self addSpaceto:key.publicAddress.string  afterWithGroupSize:4]);
    NSLog(@"Public  = %@",key.publicAddress.string);
    NSLog(@"-----------------------------------------------------------");
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end