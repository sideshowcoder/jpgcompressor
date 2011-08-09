/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"

@interface ComSideshowcoderJpgcompressorModule : TiModule 
{
}

-(id)compress:(id)args;
-(id)scale:(id)args;
-(id)compressSize;
-(void)setCompressSize:(id)value;
-(id)worstCompressQuality;
-(void)setWorstCompressQuality:(id)value;

@end
