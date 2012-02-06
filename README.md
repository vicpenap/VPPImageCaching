# VPPImageCaching

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

## License 

Copyright (c) 2012 Víctor Pena Placer ([@vicpenap](http://www.twitter.com/vicpenap))
http://www.victorpena.es/


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

