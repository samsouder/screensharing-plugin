//
//  SPSScreenSharingPlugin.h
//  Screen Sharing Plugin
//
//  Created by Samuel Souder on 9/21/09.
//  Copyright 2009 Sam Souder. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SPSScreenSharingPlugin : NSObject
{
	NSNumber* disableControlSetting;
	NSNumber* showBonjourBrowserSetting;
}

@property(copy, readwrite) NSNumber* disableControlSetting;

+ (SPSScreenSharingPlugin*)sharedInstance;
- (void)toggleControlSetting:(id)sender;
- (void)toggleBonjourBrowserSetting:(id)sender;

@end
