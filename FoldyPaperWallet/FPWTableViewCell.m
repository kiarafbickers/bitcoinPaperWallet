//
//  FPWTableViewCell.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/15/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewCell.h"

@implementation FPWTableViewCell

- (void)awakeFromNib {
    
    [self.contentView removeConstraints:self.contentView.constraints];
    
    for (UIView *subview in self.contentView.subviews) {
        [subview removeConstraints: subview.constraints];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // BEAUTY
    // view1.attributes 1 = view2.attribute = multiplier + constant
    // Giant system of linear equations. If this freaks out, fix constraints, then turn them off in interface
    
    /*
     @property (weak, nonatomic) IBOutlet UITextField *walletName;
     @property (weak, nonatomic) IBOutlet UILabel *keyPublicLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *keyPublicImage;
     @property (weak, nonatomic) IBOutlet UILabel *keyAddress;
     @property (weak, nonatomic) IBOutlet UILabel *keyPrivateLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *keyPrivateImage;
     
     */

    
    
    
    // Center
    [self.walletName.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyPublicLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyPublicImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyAddress.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
     [self.keyPrivateLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyPrivateImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    
    // Size - relettive to screen size
    [self.keyPublicImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.75].active = YES;
    [self.keyPrivateImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.75].active = YES;
    
    // Vertical postion
    [self.walletName.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:30].active = YES;
    [self.walletName.bottomAnchor constraintEqualToAnchor:self.keyPublicLabel.topAnchor constant:-10].active = YES;
    [self.keyPublicLabel.bottomAnchor constraintEqualToAnchor:self.keyPublicImage.topAnchor].active = YES;
    [self.keyPublicImage.bottomAnchor constraintEqualToAnchor:self.keyAddress.topAnchor].active = YES;
    [self.keyAddress.bottomAnchor constraintEqualToAnchor:self.keyPrivateImage.topAnchor constant:-50].active = YES;
    [self.keyPrivateLabel.bottomAnchor constraintEqualToAnchor:self.keyPrivateImage.topAnchor].active = YES;
    
    // Ratio constraiant
    [self.keyPublicImage.heightAnchor constraintEqualToAnchor:self.keyPublicImage.widthAnchor].active = YES;
    [self.keyPrivateImage.heightAnchor constraintEqualToAnchor:self.keyPrivateImage.widthAnchor].active = YES;
    [self.keyPublicLabel.widthAnchor constraintEqualToAnchor:self.keyPrivateLabel.widthAnchor].active = YES;
    [self.keyPublicImage.widthAnchor constraintEqualToAnchor:self.walletName.widthAnchor].active = YES;
    
//    [self.keyName.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
//    [self.keyPublicImage.topAnchor constraintEqualToAnchor:self.keyName.bottomAnchor].active = YES;
//    
//    [self.keyPublicImage.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:50].active = YES;
//    [self.keyPublicImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
//    [self.keyPublicImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.8].active = YES;
//    [self.keyPublicImage.heightAnchor constraintEqualToAnchor:self.keyPublicImage.widthAnchor].active = YES;
//    
//    [self.keyAddress.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
//    [self.keyPublicImage.topAnchor constraintEqualToAnchor:self.keyName.bottomAnchor].active = YES;
//    [self.keyAddress.topAnchor constraintEqualToAnchor:self.keyPublicImage.bottomAnchor].active = YES;
//    
//    [self.keyPrivateImage.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-50].active = YES;
//    [self.keyPrivateImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
//    [self.keyPrivateImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.8].active = YES;
//    [self.keyPrivateImage.heightAnchor constraintEqualToAnchor:self.keyPrivateImage.widthAnchor].active = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
