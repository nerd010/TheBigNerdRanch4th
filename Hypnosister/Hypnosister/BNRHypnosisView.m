//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Richard Wang on 23/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    path.lineWidth = 10.0;
    [self.circleColor setStroke];
    [path stroke];
    
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    CGRect logoFrame = CGRectMake(center.x - (logoImage.size.width) / 2, center.y - logoImage.size.height / 2, logoImage.size.width, logoImage.size.height);
    [logoImage drawInRect:logoFrame];
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

//BNRHypnosisView 被触摸时会收到消息
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    //获取三个0~1之间的数字
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) /100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

@end
