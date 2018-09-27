/*
 * Version for iOS © 2015–2018 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YMANativeAdAssets;
@protocol YMANativeAdDelegate;
@protocol YMANativeAdImageLoadingObserver;

/**
 * YMANativeGenericAd represents generic native ad interface and allows to get ad assets.
 */
@protocol YMANativeGenericAd <NSObject>

/**
 * Delegate is notified about clicks and transitions triggered by user interaction with ad.
 */
@property (nonatomic, weak, nullable) id<YMANativeAdDelegate> delegate;

/**
 * Adds observer which is notified about image loading progress.
 *
 * @param observer Image loading observer.
 */
- (void)addImageLoadingObserver:(id<YMANativeAdImageLoadingObserver>)observer;

/**
 * Removes observer, so it's no longer notified about image loading progress.
 *
 * @param observer Image loading observer.
 */
- (void)removeImageLoadingObserver:(id<YMANativeAdImageLoadingObserver>)observer;

/**
 * Returns ad type. @see YMANativeAdTypes.h.
 *
 * @return Ad type.
 */
- (NSString *)adType;

/**
 * Returns ad assets.
 *
 * @return Ad assets.
 */
- (YMANativeAdAssets *)adAssets;

/**
 * Arbitrary string related to ad
 */
@property (nonatomic, copy, readonly) NSString *info;

/**
 * Asynchronously loads ad's images. Every loaded image is set to corresponding UIImageView.
 * Images are not persisted in memory. It means that they should be loaded each time ad is being bound.
 * Typically every bind call should be followed by @p loadImages call 
 * if automatic image loading is disabled in @p YMANativeAdLoaderConfiguration.
 */
- (void)loadImages;

@end

NS_ASSUME_NONNULL_END
