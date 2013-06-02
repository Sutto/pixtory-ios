#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	if(self = [super init]) {
        title = ttl;
        coordinate = c2d;
    }
	return self;
}

@end