//
//  MainView.h
//  CALayerPresentation
//
//  Created by Benjamin Ragheb on 10/6/08.
//  Copyright 2008 Benjamin Ragheb. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TrayLabelDelegate;


@interface MainView : UIView {
	CALayer *deskLayer;
	CALayer *inTrayLayer;
	CALayer *outTrayLayer;
	CALayer *paperRootLayer;
	TrayLabelDelegate *trayLabelDelegate;
	// dragging
	CALayer *dragLayer;
	CGPoint dragOrigin;
}
@end
