//
//  ModelItem.h
//  DMNativeAdDemo
//
//  Created by tongle on 15/1/5.
   

#import <Foundation/Foundation.h>

@class DMNativeAd;

@interface ModelItem : NSObject

@property (nonatomic, strong) NSString *titleItem;
@property (nonatomic, strong) NSString *linkItem;
@property (nonatomic, strong) NSString *descriptionItem;
@property (nonatomic, strong) NSString *guidItem;
@property (nonatomic, strong) NSString *authorItem;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *imgUrlItem;
//声明一个变量区分 NativeAd还是正常新闻
@property (nonatomic, assign) BOOL isNativeAd;
//声明一个NativeAd的变量
@property (nonatomic, strong) DMNativeAd *nativeData;

@end
