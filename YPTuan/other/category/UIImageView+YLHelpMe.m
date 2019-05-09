//
//  UIImageView+YLHelpMe.m
//  YPTuan
//
//  Created by gd on 2018/12/13.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "UIImageView+YLHelpMe.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

static BOOL SDImagedownloderOldShouldDecompressImages = YES;
static BOOL SDImageCacheOldShouldDecompressImages = YES;
@implementation UIImageView (YLHelpMe)

- (void)hg_setImageIconWithUrlString:(id )urlString placeholder:(NSString *)placeholder{
    
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
     [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    canche.maxMemoryCost = 1;
    canche.shouldCacheImagesInMemory = NO;
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
    
    
    if (!placeholder) {
        placeholder = DefaultImageImage;
    }
    
    NSURL * url = nil;
    if ([urlString isKindOfClass:[NSURL class]]) {
        url = urlString;
    }
    if ([urlString isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:urlString];
    }
    

        
        if ([urlString rangeOfString:@"http"].location != NSNotFound) {
         
            [self sd_setImageWithURL:url placeholderImage:IMAGENAME(placeholder)];
           
        }else{
            
            [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,urlString]] placeholderImage:IMAGENAME(placeholder)];
        }
        
        //    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        
    
    
    // 每次加载图片清空memcache,

}

- (void)setMemcacheImageIconWithUrlString:(id )urlString placeholder:(NSString *)placeholder{
    
    if (!placeholder) {
        placeholder = DefaultImageImage;
    }
    
    NSURL * url = nil;
    if ([urlString isKindOfClass:[NSURL class]]) {
        url = urlString;
    }
    if ([urlString isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:urlString];
    }
    
    
    
    if ([urlString rangeOfString:@"http"].location != NSNotFound) {
        
        [self sd_setImageWithURL:url placeholderImage:IMAGENAME(placeholder)];
        
    }else{
        
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,urlString]] placeholderImage:IMAGENAME(placeholder)];
    }
    
    //    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    
    
    // 每次加载图片清空memcache,
    
}

@end
