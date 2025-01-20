
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *string = nil;
    
    NSDictionary *dic = @{@"abc": string};
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:string forKey:@"abc"];
    
    NSArray *array = @[string];
    
    NSMutableArray *_array = [[NSMutableArray alloc] init];
    [_array addObject:string];
    [_array insertObject:string atIndex:3];
    
    NSLog(@"------> %@", dic);
    NSLog(@"------> %@", params);
    NSLog(@"------> %@", array);
    NSLog(@"------> %@", _array);
}


@end
