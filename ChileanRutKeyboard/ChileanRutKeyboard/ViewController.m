//
//  ViewController.m
//  ChileanRutKeyboard
//

#import "ViewController.h"
#import "UIViewController+ChileanRutKeyboard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupChileanRutKeyboardWithUITextField:self.rutTextField];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)validateRut:(id)sender{
    self.validationLabel.text = [self isRutValid]?@"Valid":@"Not valid";
}
- (IBAction)hideKeyboard:(id)sender{
    [self hideKeyboard];
}

@end
