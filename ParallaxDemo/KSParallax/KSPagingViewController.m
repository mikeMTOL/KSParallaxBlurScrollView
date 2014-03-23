//
//  KSPagingViewController.m
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import "KSPagingViewController.h"
#import "KSParallaxItemViewController.h"
#import "Flower.h"

@interface KSPagingViewController ()

@property (nonatomic, strong) UIPageViewController* pageController;
@property (nonatomic, strong) UIScrollView* horScrollView;
@property (nonatomic, strong) UILabel* debugOffset;
@property (nonatomic, strong) NSArray* controllers;
@end

@implementation KSPagingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *options = @{@"UIPageViewControllerOptionInterPageSpacingKey":@4};
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.controllers = @[
                             [[KSParallaxItemViewController alloc] initWithFlower:[[Flower alloc]init]],
                             [[KSParallaxItemViewController alloc] initWithFlower:[[Flower alloc]init]],
                             [[KSParallaxItemViewController alloc] initWithFlower:[[Flower alloc]init]]
                            ];
    
    for(KSParallaxItemViewController* con in self.controllers){
        [con.flowerItem setImagePath:@"images/daffodils.jpg"];
        con.flowerItem.title = @"Daffodils";
        con.flowerItem.subtitle = @"Narcissus";
    }
    
//    var controllers = new List<UIViewController>()
//    {
//        new KSParallaxItemViewController(new Flower() {ImagePath = "Images/Samples/Daffodils.jpg", Title="Daffodils", Subtitle="Narcissus"}),
//        new ParallaxItemViewController(new Flower() {ImagePath = "Images/Samples/Orchids.jpg", Title="Orchids", Subtitle="Orchidaceae"}),
//        new ParallaxItemViewController(new Flower() {ImagePath = "Images/Samples/Roses.jpg", Title="Roses", Subtitle="Rosa"})
//    };
    
    // Init our pageviewer.
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:options];
    
    [self.pageController setViewControllers:@[self.controllers[0]] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];

    self.pageController.view.frame = self.view.bounds;
    self.pageController.dataSource = self;
    
    // Hooks up the scrollview so we can parallax it.
    [self setupParallax];
    
    // Add the controls to the view.
    [self.view addSubview:self.pageController.view];
    
    // Create an offset - this is for debugging purposes only.
    self.debugOffset = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    self.debugOffset.text = @"Offset = ";
    self.debugOffset.font = [UIFont systemFontOfSize:14.0f];
    self.debugOffset.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.debugOffset];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) add:(id)sender
{
    
}

/// <summary>
/// Creates the parallax effect by hooking into the scrollview.
/// </summary>
- (void) setupParallax
{
    for (id item in self.pageController.view.subviews)
    {
        // Check if there is a scrollview.
        if ([item isKindOfClass:[UIScrollView class]])
        {
            // We have a scrollview!
            self.horScrollView = (UIScrollView*)item;
//            self.horScrollView.Scrolled += horizontalScroller_Scrolled;
        }
        
        return;
    }
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.controllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.controllers count] == 0) ||
        (index >= [self.controllers count])) {
        return nil;
    }
    
    return self.controllers[index];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    return [self.controllers indexOfObject:viewController];
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
