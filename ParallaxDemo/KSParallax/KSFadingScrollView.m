//
//  KSFadingScrollView.m
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import "KSFadingScrollView.h"

@implementation KSFadingScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Create the colors for our gradient.
    UIColor *transparent = [UIColor colorWithWhite:1.0 alpha:0.0];
    UIColor *opaque = [UIColor colorWithWhite:1.0 alpha:.90];
    
    // Create a masklayer.
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.frame = self.bounds;
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(self.bounds.origin.x, 0, self.bounds.size.width, self.bounds.size.height);

    gradientLayer.colors = @[(id)transparent.CGColor, (id)transparent.CGColor, (id)opaque.CGColor, (id)opaque.CGColor];
    gradientLayer.locations = @[@0.0f, @0.09f, @0.11f, @1.0f];

    
    // Add the mask.
    [maskLayer addSublayer:gradientLayer];
//    self.layer.mask = maskLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
