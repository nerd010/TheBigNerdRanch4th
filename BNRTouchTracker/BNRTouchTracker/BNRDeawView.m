//
//  BNRDeawView.m
//  BNRTouchTracker
//
//  Created by Richard Wang on 06/12/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRDeawView.h"
#import "BNRLine.h"

@interface BNRDeawView ()

@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation BNRDeawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    //用黑色绘制已经完成的线条
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines)
    {
        [self strokeLine:line];
    }
    
    if (self.currentLine)
    {
        //用红色绘制正在画的线条
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

@end
