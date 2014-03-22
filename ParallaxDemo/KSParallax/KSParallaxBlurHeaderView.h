//
//  KSParallaxBlurHeaderView.h
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSParallaxBlurHeaderView : UIView

typedef void (^HeaderTapHandler)(id sender);

@property (strong, nonatomic)  NSString* headerTitle;
@property (strong, nonatomic)  NSString* headerSubtitle;
@property (copy, nonatomic)    HeaderTapHandler tapHandler;

@end
