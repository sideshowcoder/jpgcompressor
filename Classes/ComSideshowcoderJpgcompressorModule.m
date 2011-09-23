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

-(id)compress:(NSArray*)args
{
  // Get the local values for set keys needed
  NSNumber *cs = [self compressSize];
  NSNumber *cq = [self worstCompressQuality];
  // Get the data
  NSData *imageData;
  // Get the output path if passed
  NSString *imgName = nil;
  NSMutableString *path = [NSMutableString string];
  NSLog(@"[DEBUG] Args lenght: %u", [args count]);  
  if ([args count] > 1) {
    ENSURE_ARG_COUNT(args, 2);
    imageData = [[args objectAtIndex:0] data];
    imgName = [args objectAtIndex:1];
    [path appendString:[NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), imgName]];
    NSLog(@"[DEBUG] Output image to path: %@", path);
  } else {
    imageData = [[args objectAtIndex:0] data];
  }
  
  // DEBUG OUTPUT
  NSLog(@"[DEBUG] Received data size: %u Desired size: %@", [imageData length], cs);
  
  // Check if data is larger than desired
  if ([imageData length] > [cs intValue]) {
    // Calculate the needed compression and check if 
    CGFloat compressFactor = [cs floatValue] / [[NSNumber numberWithUnsignedInt:[imageData length]] floatValue];
    if(compressFactor < [cq floatValue]) {
      NSLog(@"[DEBUG] Compress Factor: %f Worst Quality: %f", compressFactor, [cq floatValue]);      
      compressFactor = [cq floatValue];
    }
    if(imgName != nil){
      // write to file and return path
      [UIImageJPEGRepresentation([[args objectAtIndex:0] image], compressFactor) writeToFile:path atomically:YES];
      return path;
    } else {
      // return compressed image
      NSData* compressedData = UIImageJPEGRepresentation([[args objectAtIndex:0] image], compressFactor);          
      NSLog(@"[DEBUG] Compressed size: %u Compress Factor: %f", [compressedData length], compressFactor);
      return [[[TiBlob alloc] initWithData:compressedData mimetype:@"application/octet-stream"] autorelease];
    }
  }
  // return the uncompressed image
  if(imgName != nil){
    // write to file and return path
    [UIImageJPEGRepresentation([[args objectAtIndex:0] image], 1.0) writeToFile:path atomically:YES];
    return path;
  } else {
    // return uncompressed image
    return [[[TiBlob alloc] initWithData:imageData mimetype:@"application/octet-stream"] autorelease];
  }
}

-(id)scale:(id)args
{
  // Storage for the scale size
  CGSize newSize;
  // Get the values needed from the arguments
  UIImage *image = [[args objectAtIndex:0] image];
  newSize.width = [[TiUtils numberFromObject:[args objectAtIndex:1]] floatValue];
  newSize.height = [[TiUtils numberFromObject:[args objectAtIndex:2]] floatValue];
  NSLog(@"[DBEUG] Scale size: %f x %f", newSize.width, newSize.height);
  // Do actual scaling
  UIGraphicsBeginImageContext(newSize);
  [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  // Return scaled image as blob
  return [[[TiBlob alloc] initWithImage:newImage] autorelease];
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

-(id)worstCompressQuality
{
  // when set return value else return 1 as it is 100% quality
  if ([self valueForUndefinedKey:@"worstCompressQuality"]) {
    return[self valueForUndefinedKey:@"worstCompressQuality"];
  }
  return [NSNumber numberWithInt:0];
}

-(void)setWorstCompressQuality:(id)value
{
  [self replaceValue:[TiUtils numberFromObject:value]
              forKey:@"worstCompressQuality"
        notification:NO];
}


@end
