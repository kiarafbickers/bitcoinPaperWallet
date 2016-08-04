//
//  FPWTableViewCell.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/15/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FPWTextFieldCopyOnly.h"

@interface FPWTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *keyPublicLabel;
@property (nonatomic, weak) IBOutlet UIImageView *keyPublicImage;
@property (weak, nonatomic) IBOutlet FPWTextFieldCopyOnly *keyPublicTextfield;
@property (nonatomic, weak) IBOutlet UILabel *keyPrivateLabel;
@property (weak, nonatomic) IBOutlet FPWTextFieldCopyOnly *keyPrivateTextfield;
@property (nonatomic, weak) IBOutlet UIImageView *keyPrivateImage;

@end
