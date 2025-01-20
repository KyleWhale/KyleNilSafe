
#import "NSMutableArray+NilSafe.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSMutableArray (NilSafe)

+ (void)load 
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(objectAtIndex:) swizzledSelector:@selector(kj_objectAtIndex:)];
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(kj_objectAtIndexedSubscript:)];
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(addObject:) swizzledSelector:@selector(kj_addObject:)];
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(kj_insertObject:atIndex:)];
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(removeObject:) swizzledSelector:@selector(kj_removeObject:)];
        [objc_getClass("__NSArrayM") kj_swizzleSelector:@selector(removeObjectAtIndex:) swizzledSelector:@selector(kj_removeObjectAtIndex:)];
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

- (void)kj_addObject:(id)value
{
    if (value) {
        [self kj_addObject:value];
    }
}

- (void)kj_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        return;
    }
    if (index > self.count) {
        return;
    }
    [self kj_insertObject:anObject atIndex:index];
}

- (void)kj_removeObject:(id)obj 
{
    if (obj == nil) {
        return;
    }
    [self kj_removeObject:obj];
}

- (void)kj_removeObjectAtIndex:(NSUInteger)index 
{
    if (self.count <= 0) {
        return;
    }
    if (index >= self.count) {
        return;
    }
    [self kj_removeObjectAtIndex:index];
}

@end
