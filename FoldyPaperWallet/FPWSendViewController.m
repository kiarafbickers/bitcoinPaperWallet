//
//  FPWSendViewController.m
//  FoldyPaperWallet
//
//  Created by Kiara Robles on 8/7/16.
//  Copyright © 2016 Kiara Robles. All rights reserved.
//

#import "FPWSendViewController.h"
#import "FPWTableViewController.h"

@interface FPWSendViewController ()

@property FPWTableViewController *mainViewController;

@end

@implementation FPWSendViewController

# pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)tapToGoBack:(id)sender
{
    [self cancelScreen];
}

- (void)cancelScreen
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mainViewController = (FPWTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"fpwtablevc-identifier"];
    
    [UIView transitionWithView:self.navigationController.view duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.navigationController pushViewController:self.mainViewController animated:NO];
                    }
                    completion:NULL];
}

@end
