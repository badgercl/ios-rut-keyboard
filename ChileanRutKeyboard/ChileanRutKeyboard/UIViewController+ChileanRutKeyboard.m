//
//  UIViewController+ChileanRutKeyboard.m
//  ChileanRutKeyboard
//
//  Created by Alfredo Cádiz on 6/5/14.
//  Copyright (c) 2014 Alfredo Cádiz. All rights reserved.
//

#import "UIViewController+ChileanRutKeyboard.h"
#import <limits.h>

@implementation UIViewController (ChileanRutKeyboard)



UITextField *_chileanKeyBoard;

- (void) setupChileanRutKeyboardWithUITextField:(UITextField *)textField{
    _chileanKeyBoard = textField;
    _chileanKeyBoard.keyboardType = UIKeyboardTypeNumberPad;
    _chileanKeyBoard.returnKeyType = UIReturnKeyDone;
    [_chileanKeyBoard addTarget:self action:@selector(rutFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)addButtonToKeyboard {
	// create custom button
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
}

- (void)keyboardDidShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addButtonToKeyboard];
    }
}

- (void)doneButton:(id)sender {
    _chileanKeyBoard.text = [NSString stringWithFormat:@"%@%@", _chileanKeyBoard.text, @"K"];
    [self rutFieldChanged:_chileanKeyBoard];
}

- (void) rutFieldChanged:(id) sender{
    NSString *rutStr = [[[_chileanKeyBoard.text
                         stringByReplacingOccurrencesOfString:@"," withString:@""]
                        stringByReplacingOccurrencesOfString:@"." withString:@""]
                        stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([rutStr length] > 11) {
        rutStr = [rutStr substringToIndex:[rutStr length]-1];
    }
    if([rutStr length]>2){
        NSString *rut = [rutStr substringToIndex:[rutStr length]-1];
        NSString *dv = [rutStr substringFromIndex:[rutStr length]-1];
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *number = [NSNumber numberWithInteger:[rut integerValue]];
        [formatter setGroupingSeparator:@"."];
        rut = [formatter stringFromNumber:number];
        NSString *formattedRut = [NSString stringWithFormat:@"%@-%@", rut, dv];
        _chileanKeyBoard.text = formattedRut;
    }
}

- (BOOL) isRutValid{
    NSString *rutStr = [[[_chileanKeyBoard.text
                          stringByReplacingOccurrencesOfString:@"," withString:@""]
                         stringByReplacingOccurrencesOfString:@"." withString:@""]
                        stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([rutStr length] < 1) return NO;
    NSString *rut = [rutStr substringToIndex:[rutStr length]-1];
    NSString *dv = [rutStr substringFromIndex:[rutStr length]-1];
    return [self validateRut:rut withDv:dv];
}

- (BOOL) validateRut:(NSString *)rut withDv:(NSString *)dv{
    int r=[rut intValue],m=0,s=1;
    unichar d = [dv characterAtIndex:0];
    for(;r;r/=10)s=(s+r%10*(9-m++%6))%11;
    unichar res = s?s+47:75;
    return d == res;
}

- (void) hideKeyboard{
    [_chileanKeyBoard resignFirstResponder];
}

@end

