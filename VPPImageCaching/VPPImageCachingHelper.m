//
//  VPPImageCachingHelper.m
//  VPPLibraries
//
//  Created by Víctor on 01/10/11.

// 	Copyright (c) 2012 Víctor Pena Placer (@vicpenap)
// 	http://www.victorpena.es/
// 	
// 	
// 	Permission is hereby granted, free of charge, to any person obtaining a copy 
// 	of this software and associated documentation files (the "Software"), to deal
// 	in the Software without restriction, including without limitation the rights 
// 	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// 	copies of the Software, and to permit persons to whom the Software is furnished
// 	to do so, subject to the following conditions:
// 	
// 	The above copyright notice and this permission notice shall be included in
// 	all copies or substantial portions of the Software.
// 	
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// 	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// 	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// 	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
// 	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "VPPImageCachingHelper.h"
#import "SynthesizeSingleton.h"


/* kVPPImageCachingHelperCallbackRequired
 
 when downloading the image, things can go wrong: wrong url, no 
 internet connection, etc. By default, this library only notifies 
 its caller when a succesful download is done. You can change that 
 behaviour as follows:
 - set to 0 if you don't want to be notified when an error occurs.
 - set to 1 if you do want to be notified when an error occurs. 
 
 Notification consits on executing the block passed with nil as
 argument. 
 
 The value of this constant is the default value of the callbackOnError 
 property */
#define kVPPImageCachingHelperCallbackRequired 0


@implementation VPPImageCachingHelper
@synthesize callbackOnError;

SYNTHESIZE_SINGLETON_FOR_CLASS(VPPImageCachingHelper);

+ (VPPImageCachingHelper *) sharedInstance {
    BOOL mustInitialize = !sharedVPPImageCachingHelper;
    VPPImageCachingHelper *v = [VPPImageCachingHelper sharedVPPImageCachingHelper];
    if (mustInitialize) {
        v.callbackOnError = kVPPImageCachingHelperCallbackRequired == 1 ? YES : NO;
    }
    return v;
}

- (void) imageForURL:(NSURL*)URL 
		  completion:(void (^) (UIImage *image))block {
	// wrong parameter
	if (block == nil) {
		return;
	}
	
	if (URL == nil) {
		if (self.callbackOnError) {
			block(nil);
		}	
		return;
	}
	
	// array init
	if (images_ == nil) {
		images_ = [[NSMutableDictionary alloc] init];
	}
	
	// checks if the image has been already cached
	UIImage * image;
	if ((image = [images_ objectForKey:URL]) != nil) {
		block(image);
		return;
	}
	
	// image isn't cached, so lets download it in background
	NSOperationQueue *q = [[NSOperationQueue alloc] init];
	[q addOperationWithBlock:^{
		// downloading...
		NSData *d = [NSData dataWithContentsOfURL:URL];
		
		// download wasn't succesful
		if (d == nil) {
			if (self.callbackOnError) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
					block(nil);			
				}];
			}
			return;
		}
		
		// download was succesful
		UIImage *image = [UIImage imageWithData:d];
		[[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
            [images_ setObject:image forKey:URL];
			block(image);			
		}];
	}];
	[q release];
}

- (void) flushCache {
	if (images_ != nil) {
		[images_ release];
		images_ = nil;
	}
}

@end
