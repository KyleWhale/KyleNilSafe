
#import "NSArray+NilSafe.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSArray (NilSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI") kj_swizzleSelector:@selector(objectAtIndex:) swizzledSelector:@selector(kj_objectAtIndex:)];
        [objc_getClass("__NSArrayI") kj_swizzleSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(kj_objectAtIndexedSubscript:)];
        [objc_getClass("__NSPlaceholderArray") kj_swizzleSelector:@selector(initWithObjects:count:) swizzledSelector:@selector(kj_initWithObjects:count:)];
    });
}

- (id)kj_objectAtIndex:(NSInteger)index
{
    if (index < self.count) {
        return [self kj_objectAtIndex:index];
    } else {
        return nil;
    }
}

- (id)kj_objectAtIndexedSubscript:(NSInteger)index
{
    if (index < self.count) {
        return [self kj_objectAtIndexedSubscript:index];
    } else {
        return nil;
    }
}

- (instancetype)kj_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    id nonNilObjects[cnt];
    NSUInteger nonNilCount = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] != nil) {
            nonNilObjects[nonNilCount] = objects[i];
            nonNilCount++;
        }
    }
    return [self kj_initWithObjects:nonNilObjects count:nonNilCount];
}

@end
