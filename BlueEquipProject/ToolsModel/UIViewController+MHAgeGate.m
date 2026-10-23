//
//  UIViewController+MHAgeGate.m
//  BlueEquipProject
//

#import "UIViewController+MHAgeGate.h"
#import "MHAgeAssurance.h"

@implementation UIViewController (MHAgeGate)

- (BOOL)mh_requireAdult {
    if (!MHAgeAssurance.isAgeRestricted) {
        return YES;
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:eLocalizedString(@"age_gate_title")
                                                                   message:eLocalizedString(@"age_gate_message")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:eLocalizedString(@"cancel")
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    return NO;
}

@end
