/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComSideshowcoderJpgcompressorModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComSideshowcoderJpgcompressorModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"ff873835-cf92-4d21-b2c0-0f577f0ce8f3";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.sideshowcoder.jpgcompressor";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)compress:(id)args;
{
  NSData *imageData = UIImageJPEGRepresentation([[args objectAtIndex:0] image], 1.0);
  NSLog(@"[DEBUG] Received data size: %u Desired size: %@", [imageData length], [self valueForUndefinedKey:@"compressSize"]);
  if ([imageData length] > [[self valueForUndefinedKey:@"compressSize"] intValue]) {
    CGFloat compressFactor = [[self valueForUndefinedKey:@"compressSize"] floatValue] / [[NSNumber numberWithUnsignedInt:[imageData length]] floatValue];
    NSData* compressedData = UIImageJPEGRepresentation([[args objectAtIndex:0] image], compressFactor);    
    NSLog(@"[DEBUG] Compressed size: %u Compress Factor: %f", [compressedData length], compressFactor);
    return [[[TiBlob alloc] initWithImage:[UIImage imageWithData:compressedData]] autorelease];
  }
  return [[[TiBlob alloc] initWithImage:[UIImage imageWithData:imageData]] autorelease];
}

-(id)compressSize
{
	return [self valueForUndefinedKey:@"compressSize"]; 
}

-(void)setCompressSize:(id)value
{
  [self replaceValue:[TiUtils numberFromObject:value] 
              forKey:@"compressSize" 
        notification:NO];
}

@end
