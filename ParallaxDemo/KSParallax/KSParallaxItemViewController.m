//
//  KSParallaxItemViewController.m
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import "KSParallaxItemViewController.h"
#import "KSParallaxBlurView.h"

@interface KSParallaxItemViewController ()
@property (strong, nonatomic) KSParallaxBlurView* scroll; // The scroller.

@end

@implementation KSParallaxItemViewController

- (id) initWithFlower:(Flower*) flower
{
    self = [super init];
    if(self) {
        self.flowerItem = flower;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create a new parallaxview.
    self.scroll = [[KSParallaxBlurView alloc] initWithFrame:self.view.frame];
    self.scroll.backgroundImage = [UIImage imageNamed:@"Daffodils.jpg"];
    self.scroll.headerTitle = self.flowerItem.title;
    self.scroll.headerSubtitle = self.flowerItem.subtitle;
    [self.scroll setScrollViewContentSize:CGSizeMake(320, 2000) ]; //TODO: Remove, is debug only.

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 400, 300, 1000)];
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    [self.scroll AddItemToScrollView:view];
    [self.view addSubview:self.scroll];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
