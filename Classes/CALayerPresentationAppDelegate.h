//
//  CALayerPresentationAppDelegate.h
//  CALayerPresentation
//
//  Created by Benjamin Ragheb on 10/6/08.
//  Copyright Benjamin Ragheb 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CALayerPresentationViewController;

@interface CALayerPresentationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CALayerPresentationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CALayerPresentationViewController *viewController;

@end

