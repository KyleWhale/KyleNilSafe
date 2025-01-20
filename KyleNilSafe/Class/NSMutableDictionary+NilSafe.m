
#import "NSMutableDictionary+NilSafe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (NilSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj kj_swizzleSelector:@selector(setObject:forKey:) swizzledSelector:@selector(kj_setObject:forKey:)];
    });
}

- (void)kj_setObject:(id)value forKey:(NSString *)key {
    if (value) {
        [self kj_setObject:value forKey:key];
    }
}

- (void)kj_swizzleSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
