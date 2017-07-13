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

@property (copy, nonatomic) void (^cancelCallback)(void);
@property (copy, nonatomic) void (^nextCallback)(void);

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
        UIBarButtonItem *separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
        self.toolBar.items = @[cancelItem, separator, nextItem];
        
        self.toolBar.backgroundColor = [UIColor whiteColor];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.userInteractionEnabled = YES;
    }
    
    return _toolBar;
}

- (instancetype)initWithNextCallBack:(void (^)(void))nextCallBack cancelCalllBack:(void (^)(void))cancelCallBack {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardUp)
                                                     name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDown)
                                                     name:UIKeyboardWillHideNotification object:nil];
        self.cancelCallback = cancelCallBack;
        self.nextCallback = nextCallBack;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)nextTapped {
    self.nextCallback();
}

- (void)cancel {
    self.cancelCallback();
}

- (void)keyboardUp {
    [self.window addSubview:self.toolBar];
}

- (void)keyboardDown {
    [self.toolBar removeFromSuperview];
}

@end
