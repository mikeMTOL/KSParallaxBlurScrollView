//
//  KSParallaxBlurView.m
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import "KSParallaxBlurView.h"
#import "KSFadingScrollView.h"
#import "UIImage+Blur.h"

@interface KSParallaxBlurView()

// The controls on this view.
@property (strong,nonatomic) UIScrollView* parallaxScrollView;
@property (strong,nonatomic) UIImageView* backgroundPhoto;
@property (strong,nonatomic) UIImageView* backgroundPhotoWithImageEffects;
@property (strong,nonatomic) UIView* darkerLayer;
@property (strong,nonatomic) KSFadingScrollView* scrollView;


@end

@implementation KSParallaxBlurView
- (id)init
{
    self = [super init];
    if(self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    self.parallaxSpeedRatio = 20.0f; // The speed at which the parallax image moves up and down.
    self.snappingRatio = 3; // Below one third, it snaps downwards. Otherwise upwards.
    self.darkFadeMaxOpacity = 0.2f; // The maximum opacity for the dark background overlay on scrolling.
    self.maxBlurValue = 350.0f; // At which offset the blurred image is fully visible.
    self.defaultScrollOffset = 0; // The offset at which items for the scrollview will be placed.
    
    // Set up the parallax.
    self.parallaxScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    // Set the default scroll height for the frame.
    // This is the offset where the content goes when it's snapped to the top.
    self.defaultScrollOffset = self.frame.size.height - 130 - 60 - 40 - [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    // Set up our darkening layer.
    self.darkerLayer = [[UIView alloc] initWithFrame:self.frame];
    self.darkerLayer.backgroundColor = [UIColor blackColor];
    self.darkerLayer.alpha = 0;
    
    // Set up our scrolling.
    self.scrollView = [[KSFadingScrollView alloc] initWithFrame:self.frame];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;

    // Add some events to handle the scrolling.
    self.scrollView.delegate = self;
//    scrollView.Scrolled += ScrollViewDidScroll;
//    scrollView.DraggingEnded += ScrollViewDraggingEnded;
//    scrollView.DecelerationEnded += ScrollViewDecelerationEnded;
    
    // Makes sure that a tap scrolls the view up a bit.
    UITapGestureRecognizer* tap = [UITapGestureRecognizer alloc];
    [tap addTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    
    
    // Setup the picture frame. We make it higher then the view is due to parallax.
    CGRect frame = self.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height + frame.size.height / self.parallaxSpeedRatio);
    
    // Set up the pictures.
    self.backgroundPhoto = [[UIImageView alloc] initWithFrame:frame];
    self.backgroundPhoto.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backgroundPhoto.contentMode = UIViewContentModeScaleAspectFill;

    self.backgroundPhotoWithImageEffects = [[UIImageView alloc] initWithFrame:frame];
    self.backgroundPhotoWithImageEffects.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backgroundPhotoWithImageEffects.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundPhotoWithImageEffects.alpha = 0;
    
    // Add our items to the view.
    [self.parallaxScrollView addSubview:self.backgroundPhoto];
    [self.parallaxScrollView addSubview:self.backgroundPhotoWithImageEffects];
    
    // Do the actual cross dissolve effect.
    [self crossDissolvePhotos:self.backgroundPhoto.image and:self.backgroundPhotoWithImageEffects.image];
    
    // Add our elements to the view.
    [self addSubview:self.parallaxScrollView];
    [self addSubview:self.darkerLayer];
    [self addSubview:self.scrollView];

}

- (void) tap:(id)sender
{
    if (self.scrollView.contentOffset.y == 0) {
        [self scrollToX:0 Y:self.defaultScrollOffset];
    }
}

/// <summary>
/// Add a view to the scroller.
/// </summary>
/// <param name="view"></param>
- (void)AddItemToScrollView:(UIView*) view
{
    if (self.scrollView != nil) {
        [self.scrollView addSubview:view];
    }
}

/// <summary>
/// Performs the view transition with a cross dissolve of the pictures.
/// </summary>
/// <param name="photo"></param>
- (void)crossDissolvePhotos:(UIImage*) photo and:(UIImage*) photoWithEffects
{
    [UIView transitionWithView:self.backgroundPhoto duration:0.4f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.backgroundPhoto.image = photo;
        self.backgroundPhotoWithImageEffects.image = photoWithEffects;

    } completion:nil];
}

- (void)scrollToX:(CGFloat) x Y:(CGFloat) y
{
    if (self.scrollView != nil)
    {
        // Slows the scrolling down.
        [UIView beginAnimations:@"scrollAnimation" context:nil];
        [UIView setAnimationDuration:0.3];
        [self.scrollView setContentOffset:CGPointMake(x,y) animated:YES];
        [UIView commitAnimations];
    }
}

/// <summary>
/// Scrolls the view to it's default snapping position.
/// </summary>
- (void)scrollToSnapPosition
{
    if (self.scrollView.contentOffset.y > 0 &&
        self.scrollView.contentOffset.y <= self.scrollView.frame.size.height / self.snappingRatio)
    {
        // When in the bottom part of the SnappingRatio, we snap to the original position.
        [self scrollToX:0 Y:0];
    }
//    else if (self.scrollView.contentOffset.y > self.scrollView.frame.size.height / self.snappingRatio && self.scrollView.contentOffset.y <= self.scrollView.frame.size.height)
//    {
//        // When in the top part of the SnappingRatio, we snap to the top.
//        [self scrollToX:0 Y:self.defaultScrollOffset];
//    }
}
#pragma mark - UIScrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollToSnapPosition];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO)
    {
        [self scrollToSnapPosition];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Set our parallax offset.
    if (self.scrollView.contentOffset.y / self.parallaxSpeedRatio > 0.0f &&
        self.scrollView.contentOffset.y < self.parallaxScrollView.frame.size.height &&
        self.scrollView.contentOffset.y <= self.defaultScrollOffset)
    {
        [self.parallaxScrollView setContentOffset:CGPointMake(0.0f, self.scrollView.contentOffset.y / self.parallaxSpeedRatio) animated:NO];
    }
    
    // Check if we need to fade into blurred image.
    if (self.scrollView.contentOffset.y > 0 && self.scrollView.contentOffset.y <= self.maxBlurValue)
    {
        // Percentually fade in the blurred image and fade in the dark overlay.
        float percent = (float)(self.scrollView.contentOffset.y / self.maxBlurValue);
        self.backgroundPhotoWithImageEffects.alpha = percent;
        self.darkerLayer.alpha = self.darkFadeMaxOpacity * percent;
    }
    else if (self.scrollView.contentOffset.y > self.maxBlurValue)
    {
        // Our blurred image and dark overlay are now fully visible.
        self.backgroundPhotoWithImageEffects.Alpha = 1;
        self.darkerLayer.alpha = self.darkFadeMaxOpacity;
    }
    else if (self.scrollView.contentOffset.y <= 0)
    {
        // Our blurred image and dark overlay are now fully invisible.
        self.backgroundPhotoWithImageEffects.alpha = 0;
        self.darkerLayer.alpha = 0;
    }
}

#pragma mark - Public accessors
- (UIImage*) backgroundImage
{
    return self.backgroundPhoto.image;
}

- (void) setBackgroundImage:(UIImage*)image
{
    self.backgroundPhoto.image = image;
    self.backgroundPhotoWithImageEffects.image = [UIImage blur:image];
}

- (void)setScrollViewContentSize:(CGSize)size
{
    self.scrollView.contentSize = size;
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
