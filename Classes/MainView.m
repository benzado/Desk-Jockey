//
//  MainView.m
//  CALayerPresentation
//
//  Created by Benjamin Ragheb on 10/6/08.
//  Copyright 2008 Benjamin Ragheb. All rights reserved.
//

#import "MainView.h"
#import "TrayLabelDelegate.h"


@interface MainView ()
- (CALayer *)createTrayWithLabel:(NSString *)label;
@end


@implementation MainView


- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		srandomdev();
        
		// create desk background
		deskLayer = [CALayer layer];
		deskLayer.frame = self.bounds;
		deskLayer.contents = (id)[[UIImage imageNamed:@"Desk.png"] CGImage];
		[self.layer addSublayer:deskLayer];
		
		// create trays
		trayLabelDelegate = [[TrayLabelDelegate alloc] init];

		inTrayLayer = [self createTrayWithLabel:@"IN"];
		inTrayLayer.position = CGPointMake(80, 60);
		
		outTrayLayer = [self createTrayWithLabel:@"OUT"];
		outTrayLayer.position = CGPointMake(240, 60);
		
		// create paper
		paperRootLayer = [CALayer layer];
		paperRootLayer.frame = self.bounds;
		[self.layer addSublayer:paperRootLayer];
		
		int paperCount = 10;
		while (paperCount--) {
			CALayer *sheetLayer = [CALayer layer];
			sheetLayer.backgroundColor = [[UIColor whiteColor] CGColor];
			sheetLayer.bounds = CGRectMake(0, 0, 60, 80);
			sheetLayer.position = inTrayLayer.position;
			sheetLayer.contents = (id)[[UIImage imageNamed:@"Sheet.png"] CGImage];
			[sheetLayer setValue:@"sheet" forKey:@"kind"];
			[paperRootLayer addSublayer:sheetLayer];
		}
    }
    return self;
}


- (CALayer *)createTrayWithLabel:(NSString *)label {
	CALayer *trayLayer = [CALayer layer];
	trayLayer.bounds = CGRectMake(0, 0, 80, 100);
	trayLayer.contents = (id)[[UIImage imageNamed:@"Tray.png"] CGImage];
	[deskLayer addSublayer:trayLayer];
	
	CALayer *labelLayer = [CALayer layer];
	labelLayer.bounds = CGRectMake(0, 0, 40, 16);
	labelLayer.position = CGPointMake(40, 100);
	labelLayer.delegate = trayLabelDelegate;
	[labelLayer setNeedsDisplay];
	[labelLayer setValue:label forKey:@"text"];
	[trayLayer addSublayer:labelLayer];
	
	return trayLayer;
}


- (void)dealloc {
	[trayLabelDelegate release];
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint viewPoint = [touch locationInView:self];
	CGPoint where = [paperRootLayer convertPoint:viewPoint fromLayer:self.layer];
	CALayer *hitLayer = [paperRootLayer hitTest:where];
	if (hitLayer != nil && hitLayer != paperRootLayer) {
		dragLayer = hitLayer;
		dragOrigin = hitLayer.position;
		dragLayer.zPosition = 2;
		[dragLayer setValue:[NSNumber numberWithFloat:1.5f] forKeyPath:@"transform.scale"];
		[dragLayer setValue:[NSNumber numberWithFloat:0.0f] forKeyPath:@"transform.rotation.z"];
	}
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (dragLayer != nil) {
		UITouch *touch = [touches anyObject];
		CGPoint viewPoint = [touch locationInView:self];
		CGPoint where = [paperRootLayer convertPoint:viewPoint fromLayer:self.layer];
		// disable animation while dragging
		[CATransaction flush];
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
		dragLayer.position = where;
		[CATransaction commit];
	}
}


- (void)endDragAtPosition:(CGPoint)where {
	dragLayer.position = where;
	dragLayer.zPosition = 0;
	[dragLayer setValue:[NSNumber numberWithFloat:1.0f] forKeyPath:@"transform.scale"];
	dragLayer = nil;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (dragLayer != nil) {
		UITouch *touch = [touches anyObject];
		CGPoint viewPoint = [touch locationInView:self];
		CGPoint where = [paperRootLayer convertPoint:viewPoint fromLayer:self.layer];
		
		CALayer *dropLayer = [deskLayer hitTest:where];
		if (dropLayer != nil && dropLayer != deskLayer) {
			[self endDragAtPosition:dropLayer.position];
		} else {
			// generate r in range (-1, 1)
			CGFloat r = (1000 - (random() % 2000)) / 1000.0f;
			CGFloat angle = r * M_PI_2;
			[dragLayer setValue:[NSNumber numberWithFloat:angle] forKeyPath:@"transform.rotation.z"];

			[self endDragAtPosition:where];
		}
	}
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	if (dragLayer != nil) {
		[self endDragAtPosition:dragOrigin];
	}
}
				

@end
