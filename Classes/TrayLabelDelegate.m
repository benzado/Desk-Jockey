//
//  TrayLabelDelegate.m
//  CALayerPresentation
//
//  Created by Benjamin Ragheb on 10/6/08.
//  Copyright 2008 Benjamin Ragheb. All rights reserved.
//

#import "TrayLabelDelegate.h"


@implementation TrayLabelDelegate


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	NSString *text = [layer valueForKey:@"text"];
	CGFloat fontSize = 0.75f * CGRectGetHeight(layer.bounds);
	UIFont *font = [UIFont boldSystemFontOfSize:fontSize];

	UIGraphicsPushContext(ctx);
	CGSize textSize = [text sizeWithFont:font];
	CGPoint textPoint;
	textPoint.x = 0.5f * (CGRectGetWidth(layer.bounds) - textSize.width);
	textPoint.y = 0.5f * (CGRectGetHeight(layer.bounds) - textSize.height);

	[[UIColor whiteColor] setFill];
	UIRectFill(layer.bounds);
	[[UIColor blackColor] setStroke];
	UIRectFrame(layer.bounds);
	[[UIColor blackColor] setFill];
	[text drawAtPoint:textPoint withFont:font];
	UIGraphicsPopContext();
}


@end
