//
//  FPWTableViewCell.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/15/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import "FPWTableViewCell.h"

@implementation FPWTableViewCell

- (void)awakeFromNib
{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView removeConstraints:self.contentView.constraints];
    
    for (UIView *subview in self.contentView.subviews) {
        [subview removeConstraints: subview.constraints];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }

    // Size - relative to screen size
    [self.keyPrivateImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.60].active = YES;
    [self.keyPublicImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.60].active = YES;
    
    // Size - relative to itself or other UIObjects (ratio constraiant)
    [self.keyPrivateImage.heightAnchor constraintEqualToAnchor:self.keyPrivateImage.widthAnchor].active = YES;
    [self.keyPublicImage.heightAnchor constraintEqualToAnchor:self.keyPublicImage.widthAnchor].active = YES;
    [self.keyPrivateImage.heightAnchor constraintEqualToAnchor:self.keyPublicImage.heightAnchor].active = YES;
    [self.keyPrivateImage.widthAnchor constraintEqualToAnchor:self.keyPublicImage.widthAnchor].active = YES;
    
    // Center
    [self.keyPrivateLabel.centerXAnchor constraintEqualToAnchor:self.keyPrivateImage.leadingAnchor constant:4].active = YES;
    [self.keyPrivateImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyPrivateAddress.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;

    [self.keyPublicLabel.centerXAnchor constraintEqualToAnchor:self.keyPublicImage.leadingAnchor constant:4].active = YES;
    [self.keyPublicImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.keyAddress.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    
    // Vertical postion
    [self.keyPrivateLabel.topAnchor  constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = YES;
    [self.keyPrivateLabel.bottomAnchor constraintEqualToAnchor:self.keyPrivateImage.topAnchor].active = YES;
    [self.keyPrivateImage.bottomAnchor constraintEqualToAnchor:self.keyPrivateAddress.topAnchor].active = YES;

    [self.keyPublicLabel.topAnchor  constraintEqualToAnchor:self.keyPrivateAddress.bottomAnchor constant:15].active = YES;
    [self.keyPublicLabel.bottomAnchor constraintEqualToAnchor:self.keyPublicImage.topAnchor].active = YES;
    [self.keyPublicImage.bottomAnchor constraintEqualToAnchor:self.keyAddress.topAnchor].active = YES;
    
    // Test
    [self.keyPrivateLabel.widthAnchor constraintEqualToAnchor:self.keyPublicLabel.widthAnchor].active = YES;
    [self.keyPrivateLabel.heightAnchor constraintEqualToAnchor:self.keyPublicLabel.heightAnchor].active = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
