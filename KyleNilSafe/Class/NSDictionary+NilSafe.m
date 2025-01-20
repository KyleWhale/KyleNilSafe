
#import "NSDictionary+NilSafe.h"
#import <objc/runtime.h>

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = objc_getClass("__NSPlaceholderDictionary");
        Method originalMethod = class_getInstanceMethod(class, @selector(initWithObjects:forKeys:count:));
        Method swizzledMethod = class_getInstanceMethod(class, @selector(kj_initWithObjects:forKeys:count:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)kj_initWithObjects:(const id _Nonnull [_Nullable])objects forKeys:(const id<NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt {
    id _Nonnull __unsafe_unretained newObjects[cnt];
    id <NSCopying> _Nonnull __unsafe_unretained newKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] && keys[i]) {
            newObjects[j] = objects[i];
            newKeys[j] = keys[i];
            j++;
        }
    }
    return [self kj_initWithObjects:newObjects forKeys:newKeys count:j];
}

@end
