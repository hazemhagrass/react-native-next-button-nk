//
//  KeyboardUtilityBarInterface.m
//  react_keybaord_next
//
//  Created by Mohannad A. Hassan on 7/13/17.
//  Copyright © 2017 Mohannad A. Hassan. All rights reserved.
//

#import "KeyboardUtilityBarInterface.h"
#import "KeyboardUtilityBar.h"

@interface KeyboardUtilityBarInterface ()

@property (strong, nonatomic) KeyboardUtilityBar *keyboard;

@end

@implementation KeyboardUtilityBarInterface

- (NSArray<NSString *> *)supportedEvents {
    return @[@"ClickEvent"];
}

- (void)startObserving {
    self.keyboard = [[KeyboardUtilityBar alloc] initWithNextCallBack:^{
        [self sendEventWithName:@"ClickEvent" body:@{@"name" : @"Next"}];
    } cancelCalllBack:^{
        [self sendEventWithName:@"ClickEvent" body:@{@"name" : @"Cancel"}];
    }];
}

- (void)stopObserving {
    self.keyboard = nil;
}

RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(registerCallbacks,
                 nextCallback:(RCTPromiseResolveBlock)block
                 reject:(RCTPromiseRejectBlock)eject)
{
    self.keyboard = [[KeyboardUtilityBar alloc] initWithNextCallBack:^{
        if (block != nil) {
            block(@"next");
        }
    } cancelCalllBack:^{
        if (block != nil) {
            block(@"cancel");
        }
    }];
}
@end
