ios-rut-keyboard
================

Category which modifies the native keyboard to allow chilean-style ID's. This is number + CRC, where CRC={0..10,K}
It also includes verification methods.

Usage
--------

* Copy the contents into your project
* Include `#import "UIViewController+ChileanRutKeyboard.h"` in your UIViewController
* Setup the controller providing the UITextField receiving a RUT using `[self setupChileanRutKeyboardWithUITextField:self.rutTextField];` 

Helper methods
---------------

* You can use `[self isRutValid]` to check whether the textfield has a valid RUT.
* You can hide the keyboard with the `[self hideKeyboard]` method.

TODO
------

* Include iOS7-style button
* Make it work on iOS8
* Improve button display