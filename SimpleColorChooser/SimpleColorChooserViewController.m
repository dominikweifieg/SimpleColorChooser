//
//  SimpleColorChooserViewController.m
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleColorChooserViewController.h"

#import "ArsColorChooserViewController.h"

@interface SimpleColorChooserViewController(PrivateMethods) 
-(void) setBackgroundColorForView1:(UIColor *)color;
-(void) setBackgroundColorForView2:(UIColor *)color;
-(void) setBackgroundColorForView3:(UIColor *)color;
-(void) setBackgroundColorForView4:(UIColor *)color;
-(void) colorChooserCancel;
@end

@implementation SimpleColorChooserViewController
@synthesize color1;
@synthesize color2;
@synthesize color3;
@synthesize color4;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setColor1:nil];
    [self setColor2:nil];
    [self setColor3:nil];
    [self setColor4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [color1 release];
    [color2 release];
    [color2 release];
    [color3 release];
    [color4 release];
    [super dealloc];
}
- (IBAction)chooseColor1:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView1:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color1.backgroundColor;
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor2:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView2:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color2.backgroundColor;
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor3:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView3:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color3.backgroundColor;
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor4:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView4:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color4.backgroundColor;
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

-(void) setBackgroundColorForView1:(UIColor *)color
{
    self.color1.backgroundColor = color;
    [self dismissModalViewControllerAnimated:YES];
}
-(void) setBackgroundColorForView2:(UIColor *)color
{
    self.color2.backgroundColor = color;
        [self dismissModalViewControllerAnimated:YES];
}
-(void) setBackgroundColorForView3:(UIColor *)color
{
    self.color3.backgroundColor = color;
        [self dismissModalViewControllerAnimated:YES];
}
-(void) setBackgroundColorForView4:(UIColor *)color
{
    self.color4.backgroundColor = color;
        [self dismissModalViewControllerAnimated:YES];
}

-(void) colorChooserCancel
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
