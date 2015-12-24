/**
 * Copyright (c) 2011, Philipp Fehre All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
 * following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 * disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided with the distribution.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 **/

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
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
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

  UIImage* image = [[UIImage alloc] initWithCIImage:[[args objectAtIndex:0] image]];
  // Check if data is larger than desired
  if ([imageData length] > [cs intValue]) {
    // Calculate the needed compression and check if
    CGFloat compressFactor = [cs floatValue] / [[NSNumber numberWithUnsignedLong:[imageData length]] floatValue];
    if(compressFactor < [cq floatValue]) {
      NSLog(@"[DEBUG] Compress Factor: %f Worst Quality: %f", compressFactor, [cq floatValue]);
      compressFactor = [cq floatValue];
    }

    if(imgName != nil){
      // write to file and return path
      [UIImageJPEGRepresentation(image, compressFactor) writeToFile:path atomically:YES];
      return path;
    } else {
      // return compressed image
      NSData* compressedData = UIImageJPEGRepresentation(image, compressFactor);
      NSLog(@"[DEBUG] Compressed size: %u Compress Factor: %f", [compressedData length], compressFactor);
      return [[[TiBlob alloc] initWithData:compressedData mimetype:@"application/octet-stream"] autorelease];
    }
  }
  // return the uncompressed image
  if(imgName != nil){
    // write to file and return path
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
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
  UIImage* image = [[UIImage alloc] initWithCIImage:[[args objectAtIndex:0] image]];
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
  if ([self valueForUndefinedKey:@"worstCompressQuality"]) {
    return [self valueForUndefinedKey:@"worstCompressQuality"];
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
