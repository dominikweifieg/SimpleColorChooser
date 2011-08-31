//
//  ArsColorChooserViewController.m
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArsColorChooserViewController.h"
#import "UIColor-HSVAdditions.h"

@interface ArsColorChooserViewController(PrivateMethods)
-(void) setCurrentColorMarker;
-(void) handleHueGesture:(UIGestureRecognizer *)gestureRecognizer;
-(void) handleValueGesture:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation ArsColorChooserViewController

@synthesize currentColor;
@synthesize choosenColor;
@synthesize hueImage;
@synthesize hueSelector;
@synthesize currentColorView;
@synthesize newColorView;
@synthesize theColorChooser;
@synthesize alphaLabel;
@synthesize alphaSlider;
@synthesize newMarker;
@synthesize currentMarker;

@synthesize delegate;
@synthesize colorChosenSelector;
@synthesize cancelSelector;

@synthesize hue;
@synthesize value;
@synthesize saturation;
@synthesize alpha;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithDelegate:(id) theDelegate colorChosenSelector:(SEL) theColorChosenSelector cancelSelector:(SEL) theCancelSelector
{
    self = [super initWithNibName:@"ArsColorChooserViewController" bundle:nil];
    if (self) {
        self.delegate = theDelegate;
        self.colorChosenSelector = theColorChosenSelector;
        self.cancelSelector = theCancelSelector;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGRect bounds = self.theColorChooser.bounds;
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    UIColor *startColor = [UIColor colorWithHue:self.hue saturation:1.0 brightness:1.0 alpha:1.0];
    UIColor *endColor = [UIColor colorWithHue:self.hue saturation:0.0 brightness:1.0 alpha:1.0];
    
    CGFloat colors[] =
    {
        startColor.red, startColor.green, startColor.blue, 1.0f,
        endColor.red, endColor.green, endColor.blue, 1.0f,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
    CGColorSpaceRelease(rgb);
    
    CGPoint start = bounds.origin;
    start.y = 0;
    CGPoint end = CGPointMake(bounds.origin.x, bounds.size.height);
    CGContextDrawLinearGradient(ctx, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.alpha = CGColorGetAlpha(self.currentColor.CGColor);
    self.alphaSlider.value = self.alpha;
    
    self.value = self.currentColor.value;
    
    self.saturation = self.currentColor.saturation;
    
    self.hue = self.currentColor.hue;
    
    CALayer *colorChooserLayer = [[CALayer alloc] init];
    
    [self.theColorChooser.layer addSublayer:colorChooserLayer];
    colorChooserLayer.frame = CGRectMake(0, 0, self.theColorChooser.layer.bounds.size.width, self.theColorChooser.layer.bounds.size.height);
    colorChooserLayer.delegate = self;
    [colorChooserLayer setNeedsDisplay];
    
    [colorChooserLayer release];
}

- (void)positionHueSelector {
  CGFloat hueY = hueImage.frame.origin.y;
    CGFloat hueX = (hueImage.frame.origin.x - 6) + (hueImage.frame.size.width * self.hue);
    CGRect hueSelectorFrame = hueSelector.frame;
    hueSelectorFrame.origin = CGPointMake(hueX, hueY);
    hueSelector.frame = hueSelectorFrame;

}
- (void) viewWillAppear:(BOOL)animated
{
    self.currentColorView.backgroundColor = self.currentColor;
    self.choosenColor = self.currentColor;
    self.newColorView.backgroundColor = self.choosenColor;
    
    [self positionHueSelector];

    
    UIPanGestureRecognizer *huePanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHueGesture:)];
    [self.hueImage addGestureRecognizer:huePanGestureRecognizer];
    [huePanGestureRecognizer release];
    UITapGestureRecognizer *hueTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHueGesture:)];
    [self.hueImage addGestureRecognizer:hueTap];
    [hueTap release];
    
    UIPanGestureRecognizer *chooserPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleValueGesture:)];
    [self.theColorChooser addGestureRecognizer:chooserPanGestureRecognizer];
    [chooserPanGestureRecognizer release];
    UITapGestureRecognizer *valueTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleValueGesture:)];
    [self.theColorChooser addGestureRecognizer:valueTap];
    [valueTap release];
    
    [self setCurrentColorMarker];
}

- (void)viewDidUnload
{
    [self setAlphaLabel:nil];
    [self setAlphaSlider:nil];
    [self setNewMarker:nil];
    [self setCurrentMarker:nil];
    [self setCurrentColorView:nil];
    [self setNewColorView:nil];
    [self setHueImage:nil];
    [self setHueSelector:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self setCurrentColorMarker];
}

-(void) cancel
{
    [delegate performSelector:cancelSelector];
}

-(void) done
{
    [delegate performSelector:colorChosenSelector withObject:choosenColor];
}

- (IBAction)alphaChanged:(id)sender {
    self.alpha = alphaSlider.value;
}

-(void) setCurrentColorMarker
{
    CGRect frame = self.theColorChooser.bounds;
    
    CGFloat x = frame.origin.x + (frame.size.width * self.value);
    CGFloat y = frame.origin.y + frame.size.height - (frame.size.height * self.saturation);
    
    [UIView beginAnimations:@"SetCurrentMarker" context:nil];
    CGPoint pos = [self.view convertPoint:CGPointMake(x, y - 20) fromView:self.theColorChooser];
    self.currentMarker.center = pos;
    
    if (self.choosenColor == self.currentColor) {
        self.newMarker.center = pos;
    }
    [UIView commitAnimations];
}

-(void) handleHueGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||
        gestureRecognizer.state == UIGestureRecognizerStateChanged ||
        gestureRecognizer.state == UIGestureRecognizerStateEnded) 
    {
        CGPoint p = [gestureRecognizer locationInView:self.hueImage];
        if (p.x < 0 || p.x >= self.hueImage.bounds.size.width) {
            return;
        }
        self.hue = p.x / self.hueImage.bounds.size.width;
        [self positionHueSelector];
        [[[self.theColorChooser.layer sublayers] objectAtIndex:0] setNeedsDisplay];
        self.choosenColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.value alpha:self.alpha];
        self.newColorView.backgroundColor = self.choosenColor;
    }
}
                               
-(void) handleValueGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||
        gestureRecognizer.state == UIGestureRecognizerStateChanged ||
        gestureRecognizer.state == UIGestureRecognizerStateEnded) 
    {
        CGPoint p = [gestureRecognizer locationInView:self.theColorChooser];
        if (p.x < 0 || p.x >= self.theColorChooser.bounds.size.width || 
            p.y < 0 || p.y >= self.theColorChooser.bounds.size.height ) {
            return;
        }
        
        self.value = p.x / self.theColorChooser.bounds.size.width;
        self.saturation = 1.0f - (p.y / self.theColorChooser.bounds.size.height);
        
        self.choosenColor = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.value alpha:self.alpha];
        self.newColorView.backgroundColor = self.choosenColor;
        
        CGRect frame = self.theColorChooser.bounds;
        
        CGFloat x = frame.origin.x + (frame.size.width * self.value);
        CGFloat y = frame.origin.y + frame.size.height - (frame.size.height * self.saturation);
        
        [UIView beginAnimations:@"SetCurrentMarker" context:nil];
        CGPoint pos = [self.view convertPoint:CGPointMake(x, y - 20) fromView:self.theColorChooser];
        self.newMarker.center = pos;
        [UIView commitAnimations];
    }
}
                             
- (void)dealloc {
    [alphaLabel release];
    [alphaSlider release];
    [newMarker release];
    [currentMarker release];
    [hueImage release];
    [hueSelector release];
    [self.choosenColor release];
    [super dealloc];
}
@end
