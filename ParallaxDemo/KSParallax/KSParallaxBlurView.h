//
//  KSParallaxBlurView.h
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSParallaxBlurView : UIView <UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat parallaxSpeedRatio;// The speed at which the parallax image moves up and down.
@property (assign, nonatomic) CGFloat snappingRatio;// Below one third, it snaps downwards. Otherwise upwards.
@property (assign, nonatomic) CGFloat darkFadeMaxOpacity; // The maximum opacity for the dark background overlay on scrolling.
@property (assign, nonatomic) CGFloat maxBlurValue; // At which offset the blurred image is fully visible.
@property (assign, nonatomic) CGFloat defaultScrollOffset; // The offset at which items for the scrollview will be placed.
@property (strong, nonatomic) NSString* headerTitle; // The main title for the header.
@property (strong, nonatomic) NSString* headerSubtitle; // The subtitle for the header.


- (UIImage*) backgroundImage;
- (void) setBackgroundImage:(UIImage*)image;
- (void) setHeaderTitle:(NSString *)headerTitle;
- (void) setHeaderSubtitle:(NSString *)headerSubtitle;
- (void) setScrollViewContentSize:(CGSize)size;
- (void)AddItemToScrollView:(UIView*) view;

@end
