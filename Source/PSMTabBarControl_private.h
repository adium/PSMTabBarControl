#pragma once

@interface PSMTabBarControl (Private)

// constructor/destructor
- (void)initAddedProperties;

// accessors
- (NSEvent *)lastMouseDownEvent;
- (void)setLastMouseDownEvent:(NSEvent *)event;

// contents
- (void)addTabViewItem:(NSTabViewItem *)item;
- (void)addTabViewItem:(NSTabViewItem *)item atIndex:(NSUInteger)index;
- (void)removeTabForCell:(PSMTabBarCell *)cell;

// draw
- (void)update;
- (void)update:(BOOL)animate;
- (void)_positionOverflowMenu;
- (void)_checkWindowFrame;

// actions
- (void)overflowMenuAction:(id)sender;
- (void)closeTabClick:(id)sender;
- (void)tabClick:(id)sender;
- (void)tabNothing:(id)sender;

// notification handlers
- (void)frameDidChange:(NSNotification *)notification;
- (void)windowDidMove:(NSNotification *)aNotification;
- (void)windowDidUpdate:(NSNotification *)notification;

// NSTabView delegate
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView;

// archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

// convenience
- (void)_bindPropertiesForCell:(PSMTabBarCell *)cell andTabViewItem:(NSTabViewItem *)item;
- (id)cellForPoint:(NSPoint)point cellFrame:(NSRectPointer)outFrame;

- (void)_animateCells:(NSTimer *)timer;
@end

