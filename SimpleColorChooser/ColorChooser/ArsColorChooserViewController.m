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
@synthesize titleBar;
@synthesize newColorView;
@synthesize theColorChooser;
@synthesize colorChooserFrame;
@synthesize colorChooserLayer;
@synthesize alphaLabel;
@synthesize alphaSlider;
@synthesize newMarker;

@synthesize delegate;
@synthesize colorChosenSelector;
@synthesize cancelSelector;

@synthesize alphaText;

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
    self.titleBar.topItem.title = self.title;
    
    if (self.alphaText) {
        self.alphaLabel.text = self.alphaText;
    }
    
    self.alpha = CGColorGetAlpha(self.currentColor.CGColor);
    self.alphaSlider.value = self.alpha;
    
    self.value = self.currentColor.value;
    
    self.saturation = self.currentColor.saturation;
    
    self.hue = self.currentColor.hue;
    
    self.colorChooserLayer = [[CALayer alloc] init];
    
    [self.theColorChooser.layer addSublayer:colorChooserLayer];
    colorChooserLayer.frame = CGRectMake(0, 0, self.theColorChooser.layer.bounds.size.width, self.theColorChooser.layer.bounds.size.height);
    colorChooserLayer.delegate = self;
    [colorChooserLayer setNeedsDisplay];
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
    [self setNewColorView:nil];
    [self setHueImage:nil];
    [self setHueSelector:nil];
    self.colorChooserLayer.delegate = nil;
    [self setTheColorChooser:nil];
    [self setColorChooserFrame:nil];
    [self setTitleBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {       
        CGRect frame = self.colorChooserFrame.frame;
        frame.origin = CGPointMake(10, 58);
        self.colorChooserFrame.frame = frame;
        
        frame = self.hueImage.frame;
        frame.origin = CGPointMake(250, 58);
        self.hueImage.frame = frame;
        
        frame = self.alphaLabel.frame;
        frame.origin = CGPointMake(317, 95);
        self.alphaLabel.frame = frame;
        
        frame = self.alphaSlider.frame;
        frame.origin = CGPointMake(248, 125);
        self.alphaSlider.frame = frame;
    }
    else
    {
        CGRect frame = self.colorChooserFrame.frame;
        frame.origin = CGPointMake(49, 81);
        self.colorChooserFrame.frame = frame;
        
        frame = self.hueImage.frame;
        frame.origin = CGPointMake(50, 326);
        self.hueImage.frame = frame;
        
        frame = self.alphaLabel.frame;
        frame.origin = CGPointMake(117, 373);
        self.alphaLabel.frame = frame;
        
        frame = self.alphaSlider.frame;
        frame.origin = CGPointMake(48, 402);
        self.alphaSlider.frame = frame;
    }
    [self positionHueSelector];
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
    self.newMarker.center = pos;
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
        [colorChooserLayer setNeedsDisplay];
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
    colorChooserLayer.delegate = nil;
    [colorChooserLayer release];
    [currentColor release];
    [choosenColor release];
    [delegate release];
    [colorChooserFrame release];
    [alphaText release];
    [super dealloc];
}

@end
