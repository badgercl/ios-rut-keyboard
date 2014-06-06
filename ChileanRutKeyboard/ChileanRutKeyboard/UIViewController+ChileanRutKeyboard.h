//
//  UIViewController+ChileanRutKeyboard.h
//  ChileanRutKeyboard
//
//  Created by Alfredo Cádiz on 6/5/14.
//  Copyright (c) 2014 Alfredo Cádiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ChileanRutKeyboard) <UITextFieldDelegate>
- (void) setupChileanRutKeyboardWithUITextField:(UITextField *)textField;
- (BOOL) isRutValid;
- (void) hideKeyboard;

@end
