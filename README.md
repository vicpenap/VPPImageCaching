 VPPImageCaching Library for iOS is a block-based, simple, in-memory image cache.
 
 It caches images based on their URL. No needs to configure at all. Just call
 imageForURL:completion: and the library will do the rest.
 
 When you receive low memory warnings, just call flushCache. It will drop all
 downloaded images.

 This library depends on the included SynthesizeSingleton library,
 made by Matt Gallagher.

 This project contains a sample application using it. Just open the project in 
 XCode, build it and run it. 


 For full documentation check out 
 http://vicpenap.github.com/VPPImageCaching
