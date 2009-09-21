//
//  SPSScreenSharingPlugin.m
//  Screen Sharing Plugin
//
//  Created by Samuel Souder on 9/21/09.
//  Copyright 2009 Sam Souder. All rights reserved.
//

#import "SPSScreenSharingPlugin.h"

#define DisableControlTag 54321

@implementation SPSScreenSharingPlugin

@synthesize disableControlSetting;

+ (SPSScreenSharingPlugin*)sharedInstance
{
	static SPSScreenSharingPlugin* plugin = nil;
	if ( plugin == nil )
		[[[SPSScreenSharingPlugin alloc] init] autorelease];
	return plugin;
}

+ (void)load
{
	NSLog(@"Screen Sharing Plugin Running");
	
	SPSScreenSharingPlugin* plugin = [SPSScreenSharingPlugin sharedInstance];
	
	plugin.disableControlSetting = [NSNumber numberWithBool:NO];
	
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
	[newItem setTarget:self];
	[newItem setAction:@selector(toggleControlSetting:)];
	[newMenu addItem:newItem];
	[newItem release];

}

- (BOOL)validateMenuItem:(NSMenuItem *)item
{
	NSInteger tag = [item tag];
	NSLog(@"validateMenuItem()");
	
	if (tag == DisableControlTag) {
		[item setState:([disableControlSetting boolValue]) ? NSOnState : NSOffState];
		return YES;
	} else {
		return YES;
	}
}

- (void)toggleControlSetting:(id)sender
{
	NSLog(@"toggleControlSetting()");
	
	disableControlSetting = ([disableControlSetting boolValue]) ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
}

@end
