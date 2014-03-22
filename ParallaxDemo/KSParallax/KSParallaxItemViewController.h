//
//  KSParallaxItemViewController.h
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flower.h"

@interface KSParallaxItemViewController : UIViewController

@property (strong, nonatomic) Flower* flowerItem; // The datasource for the scroller.
- (id) initWithFlower:(Flower*) flower;

@end
