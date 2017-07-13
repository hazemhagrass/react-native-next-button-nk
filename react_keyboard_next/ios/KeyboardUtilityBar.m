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
@property (strong, nonatomic) UIView *toolBarContainer;

@property (readonly, nonatomic) UIView *view;

@property (copy, nonatomic) void (^cancelCallback)(void);
@property (copy, nonatomic) void (^nextCallback)(void);

@end


@implementation KeyboardUtilityBar

- (UIWindow *)view {
    return [UIApplication sharedApplication].windows[0].subviews[0];
}


- (void)createViews {
  
  self.toolBar = [[UIToolbar alloc] init];
  CGRect windowFrame = self.view.frame;
  CGSize size = CGSizeMake(windowFrame.size.width, BarHeight);
  CGRect toolBarFrame = CGRectMake(0, 0, 0, 0);
  toolBarFrame.size = size;
  CGRect containerFrame = CGRectMake(0, windowFrame.size.height - BarHeight - 217, 0, 0);
  containerFrame.size = size;
  
  self.toolBar.frame = toolBarFrame;
  self.toolBarContainer = [[UIView alloc] initWithFrame:containerFrame];
  [self.toolBarContainer addSubview:self.toolBar];
  
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
  
  UIBarButtonItem * (^createFixedSeparator)(void) = ^ (void) {
    UIBarButtonItem *fixedSpaceSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                         target:nil
                                                                                         action:nil];
    fixedSpaceSeparator.width = 5;
    
    return fixedSpaceSeparator;
  };
  
  self.toolBar.items = @[createFixedSeparator(), cancelItem,
                         separator,
                         nextItem, createFixedSeparator()];
  
  self.toolBar.backgroundColor = [UIColor whiteColor];
  self.toolBar.barStyle = UIBarStyleDefault;
  self.toolBar.userInteractionEnabled = YES;
}

- (UIView *)toolBarContainer {
  if (_toolBarContainer == nil) {
    [self createViews];
  }
  return _toolBarContainer;
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
  [self stop];
}

- (void)nextTapped {
    self.nextCallback();
}

- (void)cancel {
    self.cancelCallback();
}

- (void)keyboardUp {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.view addSubview:self.toolBarContainer];
  });
}

- (void)keyboardDown {
  [self dismiss];
}

- (void)stop {
  [self dismiss];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dismiss {
  UIView *view = self.toolBarContainer;
  dispatch_async(dispatch_get_main_queue(), ^{
    [view removeFromSuperview];
  });
}

@end
