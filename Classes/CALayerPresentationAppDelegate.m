//
//  CALayerPresentationAppDelegate.m
//  CALayerPresentation
//
//  Created by Benjamin Ragheb on 10/6/08.
//  Copyright Benjamin Ragheb 2008. All rights reserved.
//

#import "CALayerPresentationAppDelegate.h"
#import "CALayerPresentationViewController.h"

@implementation CALayerPresentationAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
