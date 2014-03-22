//
//  KSParallaxBlurHeaderView.m
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import "KSParallaxBlurHeaderView.h"

@interface KSParallaxBlurHeaderView ()
@property (assign, nonatomic)  CGFloat paddingX;
@property (assign, nonatomic)  CGFloat paddingY;
@property (strong, nonatomic)  UILabel* titleLabel;
@property (strong, nonatomic)  UILabel* subtitleLabel;

@end

@implementation KSParallaxBlurHeaderView

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

-(void) initialize
{
    self.paddingX = 15.0f;
    self.paddingY = 20.0f;
    
    // Create the headerbuttons.
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Create the list button.
    leftButton.frame = CGRectMake(self.paddingX, self.paddingY, 32, 32);
    [leftButton setImage:[UIImage imageNamed:@"leftbutton"] forState:UIControlStateNormal];
    [self addSubview:leftButton];
    
    // Create the info button.
    rightButton.frame = CGRectMake(self.bounds.size.width - self.paddingX - 32, self.paddingY, 32, 32);
    [rightButton setImage:[UIImage imageNamed:@"rightbutton"] forState:UIControlStateNormal];
    [self addSubview:rightButton];
    
    // Create the title label.
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(46,10,228,22)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Neue-Ultra-Light" size:17.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.shadowOffset = CGSizeMake(0, 1);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = self.headerTitle;

    // Create the title label.
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(46,30,228,22)];
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Neue-Ultra-Light" size:12.0f];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.shadowOffset = CGSizeMake(0, 1);
    self.subtitleLabel.shadowColor = [UIColor blackColor];
    self.subtitleLabel.adjustsFontSizeToFitWidth = YES;
    self.subtitleLabel.text = self.headerSubtitle;

    // Add the labels to the header.
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];

    // Makes sure that a tap on the header can be handled and bubble it up.
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

-(void) setHeaderTitle:(NSString *)headerTitle
{
    _headerSubtitle = headerTitle;
    self.titleLabel.text = headerTitle;
}

-(void) setHeaderSubtitle:(NSString *)headerSubtitle
{
    _headerSubtitle = headerSubtitle;
    self.subtitleLabel.text = headerSubtitle;
}

- (void)tapped:(id) sender
{
    if(self.tapHandler!=nil) {
        self.tapHandler(sender);
    }
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
