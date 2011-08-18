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
@end

@implementation ArsColorChooserViewController

@synthesize titleLabel;
@synthesize currentColor;
@synthesize choosenColor;
@synthesize currentColorView;
@synthesize newColorView;
@synthesize theColorChooser;
@synthesize valueLabel;
@synthesize alphaLabel;
@synthesize valueSlider;
@synthesize alphaSlider;
@synthesize newMarker;
@synthesize currentMarker;

@synthesize delegate;
@synthesize colorChosenSelector;
@synthesize cancelSelector;

@synthesize value;
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

- (void)setupColorChooserButtons {
    NSArray *subviews = [NSArray arrayWithArray:self.theColorChooser.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    
    CGRect bounds = self.theColorChooser.bounds;
    
    float hue = 1 / (bounds.size.height / 5);
    float sat = 1 / (bounds.size.width / 5);

    for (int i = 0; i < bounds.size.height / 5; i++) {
        for (int j = 0; j < bounds.size.width / 5; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor colorWithHue:(hue * i) / 1  saturation: (sat * j) / 1 brightness:self.value alpha:self.alpha];
            [self.theColorChooser addSubview:button];
            button.frame = CGRectMake(j * 5, i * 5, 5, 5);
            [button addTarget:self action:@selector(colorChoosen:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchUpInside | UIControlEventTouchDragEnter];
        }
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.alpha = 1.0;//CGColorGetAlpha(self.currentColor.CGColor);
    
    self.value = 1.0;
    
    
    //[self setupColorChooserButtons];

    
}

- (void) viewWillAppear:(BOOL)animated
{
    self.currentColorView.backgroundColor = self.currentColor;
    self.choosenColor = self.currentColor;
    self.newColorView.backgroundColor = self.choosenColor;
    
    self.alpha = CGColorGetAlpha(self.currentColor.CGColor);
    self.alphaSlider.value = self.alpha;
    
    self.value = self.currentColor.value;
    self.valueSlider.value = self.value;

    [self setupColorChooserButtons];
    
    [self setCurrentColorMarker];
}

- (void)viewDidUnload
{
    [self setValueLabel:nil];
    [self setAlphaLabel:nil];
    [self setValueSlider:nil];
    [self setAlphaSlider:nil];
    [self setNewMarker:nil];
    [self setCurrentMarker:nil];
    [self setTitleLabel:nil];
    [self setCurrentColorView:nil];
    [self setNewColorView:nil];
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
    [self setupColorChooserButtons];
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

- (IBAction)valueChanged:(id)sender {
    self.value = valueSlider.value;
    [self setupColorChooserButtons];
}

- (IBAction)alphaChanged:(id)sender {
    self.alpha = alphaSlider.value;
    [self setupColorChooserButtons];
}

-(void) colorChoosen:(id)sender
{
    UIButton *b = (UIButton*) sender;
    self.choosenColor = b.backgroundColor;
    self.newColorView.backgroundColor = self.choosenColor;
    CGPoint position = [self.theColorChooser convertPoint:b.center toView:self.view];
    [UIView beginAnimations:@"SetNewMarker" context:nil];
    self.newMarker.center = CGPointMake(position.x, position.y - 20);
    [UIView commitAnimations];
}

-(void) setCurrentColorMarker
{
    CGRect frame = self.theColorChooser.frame;
    
    float hue = 1 / (frame.size.height / 5);
    float sat = 1 / (frame.size.width / 5);
    //find closest posision!
    float ySteps = self.currentColor.hue / hue;
    ySteps *= 5;
    
    float xSteps = self.currentColor.saturation / sat;
    xSteps *= 5;
    [UIView beginAnimations:@"SetCurrentMarker" context:nil];
    CGPoint pos = [self.view convertPoint:CGPointMake(xSteps, ySteps - 20) fromView:self.theColorChooser];
    self.currentMarker.center = pos;
    
    if (self.choosenColor == self.currentColor) {
        self.newMarker.center = pos;
    }
    [UIView commitAnimations];
}

- (void)dealloc {
    [valueLabel release];
    [alphaLabel release];
    [valueSlider release];
    [alphaSlider release];
    [newMarker release];
    [currentMarker release];
    [super dealloc];
}
@end
