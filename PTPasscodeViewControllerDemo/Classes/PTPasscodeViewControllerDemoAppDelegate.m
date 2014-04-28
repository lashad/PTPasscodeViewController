//
//  PTPasscodeViewControllerDemoAppDelegate.m
//  PTPasscodeViewControllerDemo
//
//  Created by Lasha Dolidze on 7/7/10.
//  Distributed under MIT license
//

#import "PTPasscodeViewControllerDemoAppDelegate.h"
#import "PTPasscodeViewController.h"


@implementation PTPasscodeViewControllerDemoAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:rect];
    [self setWindow:window];
    
    
    PTPasscodeViewController *passcodeViewController = [[PTPasscodeViewController alloc] initWithDelegate:self];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:passcodeViewController];
    
    [self setNavigationController:navController];
    
    [window addSubview:[navController view]];
    [window makeKeyAndVisible];
    
    return TRUE;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void) didShowPasscodePanel:(PTPasscodeViewController *)passcodeViewController panelView:(UIView*)panelView
{
    [passcodeViewController setTitle:@"Set Passcode"];
    
    if([panelView tag] == kPasscodePanelOne) {
       [[passcodeViewController titleLabel] setText:@"Enter a passcode"];
    }

    if([panelView tag] == kPasscodePanelTwo) {
        [[passcodeViewController titleLabel] setText:@"Re-enter your passcode"];
    }

    if([panelView tag] == kPasscodePanelThree) {
        [[passcodeViewController titleLabel] setText:@"Panel 3"];
    }
}

- (BOOL)shouldChangePasscode:(PTPasscodeViewController *)passcodeViewController panelView:(UIView*)panelView passCode:(NSUInteger)passCode lastNumber:(NSInteger)lastNumber;
{
    // Clear summary text
    [[passcodeViewController summaryLabel] setText:@""];

    return TRUE;
}

- (BOOL)didEndPasscodeEditing:(PTPasscodeViewController *)passcodeViewController panelView:(UIView*)panelView passCode:(NSUInteger)passCode
{
    
    NSLog(@"END PASSCODE - %d", passCode);
    
    if([panelView tag] == kPasscodePanelOne) {
        _passCode = passCode;
        
       
        /*if(_passCode != passCode) {
            [[passcodeViewController summaryLabel] setText:@"Invalid PIN code"];
            [[passcodeViewController summaryLabel] setTextColor:[UIColor redColor]];
            [passcodeViewController clearPanel];
            return FALSE;
        }*/
 
        return ![passcodeViewController nextPanel];
    }

    if([panelView tag] == kPasscodePanelTwo) {
        _retryPassCode = passCode;
        
        if(_retryPassCode != _passCode) {
            [passcodeViewController prevPanel];
            [[passcodeViewController summaryLabel] setText:@"Passcode did not match. Try again."];
            return FALSE;
        } else {
            [[passcodeViewController summaryLabel] setText:@"Good boy !"];    
        }
        
    }
    
  //  return ![passcodeView nextPanel];
    
    return TRUE;
}


@end

