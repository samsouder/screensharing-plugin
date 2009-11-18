//
//  SPSScreenSharingPlugin.m
//  Screen Sharing Plugin
//
//  Created by Samuel Souder on 9/21/09.
//  Copyright 2009 Sam Souder. All rights reserved.
//

#import "SPSScreenSharingPlugin.h"

#define DisableControlTag 1
#define FullScreenTag 2

@implementation SPSScreenSharingPlugin

@synthesize disableControlSetting, fullScreenSetting;

+ (SPSScreenSharingPlugin*)sharedInstance
{
	static SPSScreenSharingPlugin* plugin = nil;
	if ( plugin == nil )
		plugin = [[SPSScreenSharingPlugin alloc] init];
	return plugin;
}

+ (void)load
{
	NSLog(@"Screen Sharing Plugin Running");
	
	SPSScreenSharingPlugin* plugin = [SPSScreenSharingPlugin sharedInstance];
	
	plugin.disableControlSetting = [NSNumber numberWithBool:NO];
	plugin.fullScreenSetting = [NSNumber numberWithBool:NO];
	
	NSMenu *newMenu;
	NSMenuItem *newItem;
	
	// Add the submenu
	newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Advanced" action:NULL keyEquivalent:@""];
	newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"Advanced"];
	[newItem setSubmenu:newMenu];
	[newMenu release];
	[[NSApp mainMenu] addItem:newItem];
	[newItem release];
	
	// Add some cool items
	newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Disable Control" action:NULL keyEquivalent:@""];
	[newItem setTag:DisableControlTag];
	[newItem setTarget:[SPSScreenSharingPlugin sharedInstance]];
	[newItem setAction:@selector(toggleControlSetting:)];
	[newMenu addItem:newItem];
	[newItem release];
	
	newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Enter Fullscreen" action:NULL keyEquivalent:@""];
	[newItem setTag:FullScreenTag];
	[newItem setTarget:[SPSScreenSharingPlugin sharedInstance]];
	[newItem setAction:@selector(toggleFullScreenSetting:)];
	[newMenu addItem:newItem];
	[newItem release];
}

- (void)dealloc
{
	[disableControlSetting release];
	[super dealloc];
}

- (BOOL)validateMenuItem:(NSMenuItem *)item
{
	NSInteger tag = [item tag];
	if (tag == DisableControlTag) {
		[item setState:([disableControlSetting boolValue]) ? NSOnState : NSOffState];
		return YES;
	} else if (tag == FullScreenTag) {
		[item setState:([fullScreenSetting boolValue]) ? NSOnState : NSOffState];
		return YES;
	} else {
		return YES;
	}
}

- (void)toggleControlSetting:(id)sender
{
	disableControlSetting = ([disableControlSetting boolValue]) ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
	
	// enable/disable control
	// RFBImageView
	[[[NSApp mainWindow] firstResponder] setControl:![disableControlSetting boolValue] shared:![disableControlSetting boolValue]];
}

- (void)toggleFullScreenSetting:(id)sender
{
	fullScreenSetting = ([fullScreenSetting boolValue]) ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
	
	// go fullscreen or exit fullscreen
	if ([fullScreenSetting boolValue]) {
		// RFBImageView > RDNotificationWindow > RFBSessionController
		[[[[[NSApp mainWindow] firstResponder] window] delegate] enterFullScreen];
	} else {
		[[[[[NSApp mainWindow] firstResponder] window] delegate] enterWindowed];
		[[[[[NSApp mainWindow] firstResponder] window] delegate] exitFullScreen];
	}
}

@end
