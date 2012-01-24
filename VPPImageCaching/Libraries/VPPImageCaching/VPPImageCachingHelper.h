//
//  VPPImageCachingHelper.h
//  VPPLibraries
//
//  Created by Víctor on 01/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 VPPImageCaching Library is a block-based, simple, in-memory image cache.
 
 It caches images based on their URL. No needs to configure at all. Just call
 imageForURL:completion: and the library will do the rest.
 
 When you receive low memory warnings, just call flushCache. It will drop all
 downloaded images.
 
 @warning This library depends on the included SynthesizeSingleton library,
 made by Matt Gallagher.
 */


@interface VPPImageCachingHelper : NSObject {
	
@private
	NSMutableDictionary *images_;
}

/** ---
 @name Helper configuration
 */

/** Indicates if there must be a callback when an error while downloading occurs.
 
 When downloading the image, things can go wrong: wrong url, no 
 internet connection, etc. By default, this library only notifies 
 its caller when a succesful download is done. You can change that 
 behaviour as follows:
 
 - set to NO if you don't want to be notified when an error occurs.
 - set to YES if you do want to be notified when an error occurs. 
 
 Notification consits on executing the block passed with nil as
 argument. 
 */
@property (nonatomic, assign) BOOL callbackOnError;


/** ---
 @name Accessing the singleton instance 
 */
/// Returns the VPPImageCachingHelper singleton instance
+ (VPPImageCachingHelper *) sharedInstance;



/** ---
 @name Using the cache
 */

/** Returns the image stored in the URL specified. 

 If the image is cached, it is returned instantly through the 
 execution in main thread of the block passed as argument.
 
 If the image isn't cached, it'll be downloaded in background. When 
 finished, it'll be returned through the 
 execution in main thread of the block passed as argument.
 
 If callbackOnError is set to true the block will be also executed when the
 download fails, passing nil as image.
 */
- (void) imageForURL:(NSURL*)URL
		  completion:(void (^) (UIImage *image))block;


/// Removes all cached images. Use this on low memory warnings.
- (void) flushCache;

@end
