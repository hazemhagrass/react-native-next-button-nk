//
//  KeyboardUtilityBar.h
//  react_keybaord_next
//
//  Created by Mohannad A. Hassan on 7/12/17.
//  Copyright © 2017 Mohannad A. Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardUtilityBar : NSObject

- (nullable instancetype)initWithNextCallBack:(nonnull void (^) (void))nextCallBack
                              cancelCalllBack:(nonnull void (^) (void))cancelCallBack;

@end
