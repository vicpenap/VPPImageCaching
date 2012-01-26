//
//  XMLParserExample.h
//  VPPLibraries
//
//  Created by Víctor on 26/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageCachingExample : UITableViewController {
@private
	BOOL loading;
    NSArray *images;
}

@property (nonatomic, retain) NSArray *images;

@end
