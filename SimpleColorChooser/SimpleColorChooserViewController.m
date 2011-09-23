//
//  SimpleColorChooserViewController.m
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 Ars Subtilior. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
//    associated documentation files (the "Software"), to deal in the Software without restriction, 
//    including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial 
//    portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
//    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN 
//    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
//    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


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
    colorChooser.title = @"Farbe wählen";
    colorChooser.alphaText = @"Transparenz";
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        colorChooser.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor2:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView2:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color2.backgroundColor;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        colorChooser.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor3:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView3:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color3.backgroundColor;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        colorChooser.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentModalViewController:colorChooser animated:YES];
    [colorChooser release];
}

- (IBAction)chooseColor4:(id)sender {
    ArsColorChooserViewController *colorChooser = [[ArsColorChooserViewController alloc] initWithDelegate:self colorChosenSelector:@selector(setBackgroundColorForView4:) cancelSelector:@selector(colorChooserCancel)];
    colorChooser.currentColor = self.color4.backgroundColor;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        colorChooser.modalPresentationStyle = UIModalPresentationFormSheet;
    }
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
