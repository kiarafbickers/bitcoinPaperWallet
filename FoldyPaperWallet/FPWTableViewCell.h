//
//  FPWTableViewCell.h
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 10/15/15.
//  Copyright © 2015 Kiara Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FPWTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *keyPublicLabel;
@property (nonatomic, weak) IBOutlet UIImageView *keyPublicImage;
@property (nonatomic, weak) IBOutlet UILabel *keyAddress;
@property (nonatomic, weak) IBOutlet UILabel *keyPrivateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *keyPrivateImage;

@end
