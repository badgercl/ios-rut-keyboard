//
//  ViewController.h
//  ChileanRutKeyboard
//
//  Created by Alfredo Cádiz on 6/5/14.
//  Copyright (c) 2014 Alfredo Cádiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak) IBOutlet UITextField *rutTextField;
@property (weak) IBOutlet UILabel *validationLabel;

- (IBAction)validateRut:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
