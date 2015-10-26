//
//  CustomAlbum.h
//  CustomPhotoAlbum
//
//  Created by Balaji Malliswamy on 26/10/15.
//  Copyright © 2015 CodeSkip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


@interface CustomAlbum : NSObject

//Creating album with given name
+(void)makeAlbumWithTitle:(NSString *)title onSuccess:(void(^)(NSString *AlbumId))onSuccess onError: (void(^)(NSError * error)) onError;

//Get the album by name
+(PHAssetCollection *)getMyAlbumWithName:(NSString*)AlbumName;

//Add a image
+(void)addNewAssetWithImage:(UIImage *)image toAlbum:(PHAssetCollection *)album onSuccess:(void(^)(NSString *ImageId))onSuccess onError: (void(^)(NSError * error)) onError;

//get the image using identifier
+ (void)getImageWithIdentifier:(NSString*)imageId onSuccess:(void(^)(UIImage *image))onSuccess onError: (void(^)(NSError * error)) onError;


@end
