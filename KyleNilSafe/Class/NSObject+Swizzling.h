

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)kj_swizzleSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
