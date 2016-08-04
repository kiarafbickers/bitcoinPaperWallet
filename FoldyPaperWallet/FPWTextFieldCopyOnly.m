//
//  FPWTextFieldCopyOnly.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 8/3/16.
//  Copyright © 2016 Kiara Robles. All rights reserved.
//

#import "FPWTextFieldCopyOnly.h"

@implementation FPWTextFieldCopyOnly

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)) {
        return true;
    } else if (action == @selector(selectAll:)) {
        return true;
    }
    
    return false;
}

// The UITextField's inputView property is nil by default, which means the standard keyboard gets displayed. If you assign it a custom input view then the keyboard will not appear, and the blinking cursor will still appear.

- (UIView *)inputView
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}

@end
