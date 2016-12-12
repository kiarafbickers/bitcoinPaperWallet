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

@interface FPWTableViewGenerateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *keyPrivateMumonic;
@property (nonatomic, weak) IBOutlet UIImageView *keyPublicImage;
@property (weak, nonatomic) IBOutlet UILabel *keyPublicLabel;

@end
