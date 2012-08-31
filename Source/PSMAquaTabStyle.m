//
//  PSMAquaTabStyle.m
//  PSMTabBarControl
//
//  Created by John Pannell on 2/17/06.
//  Copyright 2006 Positive Spin Media. All rights reserved.
//

#import "PSMAquaTabStyle.h"
#import "PSMTabBarCell.h"
#import "PSMTabBarControl.h"

@implementation PSMAquaTabStyle

- (NSString *)name {
	return @"Aqua";
}

#pragma mark -
#pragma mark Creation/Destruction

- (id) init {
	if((self = [super init])) {
		[self loadImages];

		_objectCountStringAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSFontManager sharedFontManager] convertFont:[NSFont fontWithName:@"Helvetica" size:11.0] toHaveTrait:NSBoldFontMask], NSFontAttributeName,
										[[NSColor whiteColor] colorWithAlphaComponent:0.85], NSForegroundColorAttributeName,
										nil, nil];
	}
	return self;
}

- (void) loadImages {
	// Aqua Tabs Images
	aquaTabBg = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsBackground"]];
	[aquaTabBg setFlipped:YES];

	aquaTabBgDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsDown"]];
	[aquaTabBgDown setFlipped:YES];

	aquaTabBgDownGraphite = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsDownGraphite"]];
	[aquaTabBgDown setFlipped:YES];

	aquaTabBgDownNonKey = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsDownNonKey"]];
	[aquaTabBgDown setFlipped:YES];

	aquaDividerDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsSeparatorDown"]];
	[aquaDivider setFlipped:NO];

	aquaDivider = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabsSeparator"]];
	[aquaDivider setFlipped:NO];

	aquaCloseButton = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabClose_Front"]];
	aquaCloseButtonDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabClose_Front_Pressed"]];
	aquaCloseButtonOver = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabClose_Front_Rollover"]];

	aquaCloseDirtyButton = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabCloseDirty_Front"]];
	aquaCloseDirtyButtonDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabCloseDirty_Front_Pressed"]];
	aquaCloseDirtyButtonOver = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabCloseDirty_Front_Rollover"]];

	_addTabButtonImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabNew"]];
	_addTabButtonPressedImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabNewPressed"]];
	_addTabButtonRolloverImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"AquaTabNewRollover"]];
}

- (void)dealloc {
	[aquaTabBg release];
	[aquaTabBgDown release];
	[aquaDividerDown release];
	[aquaDivider release];
	[aquaCloseButton release];
	[aquaCloseButtonDown release];
	[aquaCloseButtonOver release];
	[aquaCloseDirtyButton release];
	[aquaCloseDirtyButtonDown release];
	[aquaCloseDirtyButtonOver release];
	[_addTabButtonImage release];
	[_addTabButtonPressedImage release];
	[_addTabButtonRolloverImage release];

	[_objectCountStringAttributes release];

	[super dealloc];
}

#pragma mark -
#pragma mark Control Specifics

- (CGFloat)leftMarginForTabBarControl {
	return 0.0f;
}

- (CGFloat)rightMarginForTabBarControl {
	return 24.0f;
}

- (CGFloat)topMarginForTabBarControl {
	return 0.0f;
}

- (void)setOrientation:(PSMTabBarOrientation)value {
}

#pragma mark -
#pragma mark Add Tab Button

- (NSImage *)addTabButtonImage {
	return _addTabButtonImage;
}

- (NSImage *)addTabButtonPressedImage {
	return _addTabButtonPressedImage;
}

- (NSImage *)addTabButtonRolloverImage {
	return _addTabButtonRolloverImage;
}

#pragma mark -
#pragma mark Drag Support

- (NSRect)dragRectForTabCell:(PSMTabBarCell *)cell orientation:(PSMTabBarOrientation)orientation {
	return [cell frame];
}

#pragma mark -
#pragma mark Providing Images

- (NSImage *)closeButtonImageOfType:(PSMCloseButtonImageType)type forTabCell:(PSMTabBarCell *)cell
{
    switch (type) {
        case PSMCloseButtonImageTypeStandard:
            return aquaCloseButton;
        case PSMCloseButtonImageTypeRollover:
            return aquaCloseButtonOver;
        case PSMCloseButtonImageTypePressed:
            return aquaCloseButtonDown;
            
        case PSMCloseButtonImageTypeDirty:
            return aquaCloseDirtyButton;
        case PSMCloseButtonImageTypeDirtyRollover:
            return aquaCloseDirtyButtonOver;
        case PSMCloseButtonImageTypeDirtyPressed:
            return aquaCloseDirtyButtonDown;
            
        default:
            break;
    }
    
}  // -closeButtonImageOfType:


#pragma mark -
#pragma mark Determining Cell Size

- (CGFloat)tabCellHeight {
	return kPSMTabBarControlHeight;
}

#pragma mark -
#pragma mark Cell Values

- (NSAttributedString *)attributedObjectCountValueForTabCell:(PSMTabBarCell *)cell {
	NSString *contents = [NSString stringWithFormat:@"%lu", (unsigned long)[cell count]];
	return [[[NSMutableAttributedString alloc] initWithString:contents attributes:_objectCountStringAttributes] autorelease];
}

- (NSAttributedString *)attributedStringValueForTabCell:(PSMTabBarCell *)cell {
	NSMutableAttributedString *attrStr;
	NSString * contents = [cell stringValue];
	attrStr = [[[NSMutableAttributedString alloc] initWithString:contents] autorelease];
	NSRange range = NSMakeRange(0, [contents length]);

	[attrStr addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:11.0] range:range];

	// Paragraph Style for Truncating Long Text
	static NSMutableParagraphStyle *TruncatingTailParagraphStyle = nil;
	if(!TruncatingTailParagraphStyle) {
		TruncatingTailParagraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] retain];
		[TruncatingTailParagraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
		[TruncatingTailParagraphStyle setAlignment:NSCenterTextAlignment];
	}
	[attrStr addAttribute:NSParagraphStyleAttributeName value:TruncatingTailParagraphStyle range:range];

	return attrStr;
}

#pragma mark -
#pragma mark Drawing

- (void)drawBezelOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inView:(id)controlView {

	NSRect cellFrame = frame;

	// Selected Tab
	if([cell state] == NSOnState) {
		NSRect aRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height - 2.5);
		aRect.size.height -= 0.5;

		// proper tint
		NSControlTint currentTint;
		if([cell controlTint] == NSDefaultControlTint) {
			currentTint = [NSColor currentControlTint];
		} else{
			currentTint = [cell controlTint];
		}

		if(![[[cell controlView] window] isKeyWindow]) {
			currentTint = NSClearControlTint;
		}

		NSImage *bgImage;
		switch(currentTint) {
		case NSGraphiteControlTint:
			bgImage = aquaTabBgDownGraphite;
			break;
		case NSClearControlTint:
			bgImage = aquaTabBgDownNonKey;
			break;
		case NSBlueControlTint:
		default:
			bgImage = aquaTabBgDown;
			break;
		}

		[bgImage drawInRect:cellFrame fromRect:NSMakeRect(0.0, 0.0, 1.0, 22.0) operation:NSCompositeSourceOver fraction:1.0];
        [aquaDivider drawAtPoint:NSMakePoint(cellFrame.origin.x + cellFrame.size.width - 1.0, cellFrame.origin.y) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

		aRect.size.height += 0.5;
	} else { // Unselected Tab
		NSRect aRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
		aRect.origin.y += 0.5;
		aRect.origin.x += 1.5;
		aRect.size.width -= 1;

		aRect.origin.x -= 1;
		aRect.size.width += 1;

		// Rollover
		if([cell isHighlighted]) {
			[[NSColor colorWithCalibratedWhite:0.0 alpha:0.1] set];
			NSRectFillUsingOperation(aRect, NSCompositeSourceAtop);
		}

        [aquaDivider drawAtPoint:NSMakePoint(cellFrame.origin.x + cellFrame.size.width - 1.0, cellFrame.origin.y) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
}

- (void)drawBackgroundInRect:(NSRect)rect {
	if(rect.size.height <= 22.0) {
		//Draw for our whole bounds; it'll be automatically clipped to fit the appropriate drawing area
		rect = [tabBar bounds];

		[aquaTabBg drawInRect:rect fromRect:NSMakeRect(0.0, 0.0, 1.0, 22.0) operation:NSCompositeSourceOver fraction:1.0];
	}
}

- (void)drawTabBar:(PSMTabBarControl *)bar inRect:(NSRect)rect {
	if(tabBar != bar) {
		tabBar = bar;
	}

	[self drawBackgroundInRect:rect];

	// no tab view == not connected
	if(![bar tabView]) {
		NSRect labelRect = rect;
		labelRect.size.height -= 4.0;
		labelRect.origin.y += 4.0;
		NSMutableAttributedString *attrStr;
		NSString *contents = @"PSMTabBarControl";
		attrStr = [[[NSMutableAttributedString alloc] initWithString:contents] autorelease];
		NSRange range = NSMakeRange(0, [contents length]);
		[attrStr addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:11.0] range:range];
		NSMutableParagraphStyle *centeredParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [centeredParagraphStyle setAlignment:NSCenterTextAlignment];

		[attrStr addAttribute:NSParagraphStyleAttributeName value:centeredParagraphStyle range:range];
		[attrStr drawInRect:labelRect];
        
        [centeredParagraphStyle release];
		return;
	}

	// Draw cells
	NSEnumerator *e = [[bar cells] objectEnumerator];
	PSMTabBarCell *cell;
	while((cell = [e nextObject])) {
		if([bar isAnimating] || (![cell isInOverflowMenu] && NSIntersectsRect([cell frame], rect))) {
			[cell drawWithFrame:[cell frame] inView:bar];
		}
	}
}

#pragma mark -
#pragma mark Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
	//[super encodeWithCoder:aCoder];
	if([aCoder allowsKeyedCoding]) {
		[aCoder encodeObject:aquaTabBg forKey:@"aquaTabBg"];
		[aCoder encodeObject:aquaTabBgDown forKey:@"aquaTabBgDown"];
		[aCoder encodeObject:aquaTabBgDownGraphite forKey:@"aquaTabBgDownGraphite"];
		[aCoder encodeObject:aquaTabBgDownNonKey forKey:@"aquaTabBgDownNonKey"];
		[aCoder encodeObject:aquaDividerDown forKey:@"aquaDividerDown"];
		[aCoder encodeObject:aquaDivider forKey:@"aquaDivider"];
		[aCoder encodeObject:aquaCloseButton forKey:@"aquaCloseButton"];
		[aCoder encodeObject:aquaCloseButtonDown forKey:@"aquaCloseButtonDown"];
		[aCoder encodeObject:aquaCloseButtonOver forKey:@"aquaCloseButtonOver"];
		[aCoder encodeObject:aquaCloseDirtyButton forKey:@"aquaCloseDirtyButton"];
		[aCoder encodeObject:aquaCloseDirtyButtonDown forKey:@"aquaCloseDirtyButtonDown"];
		[aCoder encodeObject:aquaCloseDirtyButtonOver forKey:@"aquaCloseDirtyButtonOver"];
		[aCoder encodeObject:_addTabButtonImage forKey:@"addTabButtonImage"];
		[aCoder encodeObject:_addTabButtonPressedImage forKey:@"addTabButtonPressedImage"];
		[aCoder encodeObject:_addTabButtonRolloverImage forKey:@"addTabButtonRolloverImage"];
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	//self = [super initWithCoder:aDecoder];
	//if (self) {
	if([aDecoder allowsKeyedCoding]) {
		aquaTabBg = [[aDecoder decodeObjectForKey:@"aquaTabBg"] retain];
		aquaTabBgDown = [[aDecoder decodeObjectForKey:@"aquaTabBgDown"] retain];
		aquaTabBgDownGraphite = [[aDecoder decodeObjectForKey:@"aquaTabBgDownGraphite"] retain];
		aquaTabBgDownNonKey = [[aDecoder decodeObjectForKey:@"aquaTabBgDownNonKey"] retain];
		aquaDividerDown = [[aDecoder decodeObjectForKey:@"aquaDividerDown"] retain];
		aquaDivider = [[aDecoder decodeObjectForKey:@"aquaDivider"] retain];
		aquaCloseButton = [[aDecoder decodeObjectForKey:@"aquaCloseButton"] retain];
		aquaCloseButtonDown = [[aDecoder decodeObjectForKey:@"aquaCloseButtonDown"] retain];
		aquaCloseButtonOver = [[aDecoder decodeObjectForKey:@"aquaCloseButtonOver"] retain];
		aquaCloseDirtyButton = [[aDecoder decodeObjectForKey:@"aquaCloseDirtyButton"] retain];
		aquaCloseDirtyButtonDown = [[aDecoder decodeObjectForKey:@"aquaCloseDirtyButtonDown"] retain];
		aquaCloseDirtyButtonOver = [[aDecoder decodeObjectForKey:@"aquaCloseDirtyButtonOver"] retain];
		_addTabButtonImage = [[aDecoder decodeObjectForKey:@"addTabButtonImage"] retain];
		_addTabButtonPressedImage = [[aDecoder decodeObjectForKey:@"addTabButtonPressedImage"] retain];
		_addTabButtonRolloverImage = [[aDecoder decodeObjectForKey:@"addTabButtonRolloverImage"] retain];
	}
	//}
	return self;
}

@end
