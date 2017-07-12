//
//  KeyboardUtilityBar.m
//  react_keybaord_next
//
//  Created by Mohannad A. Hassan on 7/12/17.
//  Copyright © 2017 Mohannad A. Hassan. All rights reserved.
//

#import "KeyboardUtilityBar.h"

static const NSInteger BarHeight = 42;

@interface KeyboardUtilityBar ()

@property (strong, nonatomic) UIToolbar *toolBar;

@property (readonly, nonatomic) UIWindow *window;

@end

@implementation KeyboardUtilityBar

- (UIWindow *)window {
    return [UIApplication sharedApplication].windows[0];
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        self.toolBar = [[UIToolbar alloc] init];
        CGRect windowFrame = self.window.frame;
        self.toolBar.frame = CGRectMake(0, windowFrame.size.height - BarHeight - 217,
                                        windowFrame.size.width, BarHeight);
        
        UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(nextTapped)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancel)];
        self.toolBar.items = @[nextItem, cancelItem];
        
        self.toolBar.backgroundColor = [UIColor whiteColor];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.userInteractionEnabled = YES;
    }
    
    return _toolBar;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardUp)
                                                     name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDown)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)nextTapped {
    
}

- (void)cancel {
    
}

- (void)keyboardUp {
    [self.window addSubview:self.toolBar];
}

- (void)keyboardDown {
    [self.toolBar removeFromSuperview];
}

@end
