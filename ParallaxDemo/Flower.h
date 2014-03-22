//
//  Flower.h
//  ParallaxDemo
//
//  Created by salah on 2014-03-21.
//  Copyright (c) 2014 kronositi inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flower : NSObject

@property (strong, nonatomic) NSString* imagePath; // Needed to set the background.
@property (strong, nonatomic) NSString* title; // Sets the title at the top.
@property (strong, nonatomic) NSString* subtitle; // Sets the subtitle at the top.

@end
