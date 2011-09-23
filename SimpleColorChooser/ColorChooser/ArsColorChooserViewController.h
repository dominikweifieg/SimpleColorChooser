//
//  ArsColorChooserViewController.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ArsColorChooserViewController : UIViewController {

    UIView  *newColorView;
    
    UIView  *theColorChooser;
    UIView *colorChooserFrame;
    CALayer *colorChooserLayer;
    UILabel *alphaLabel;
    UISlider *alphaSlider;
    UIView *newMarker;
    
    UIColor *currentColor;
    UIColor *choosenColor;
    UIImageView *hueImage;
    UIImageView *hueSelector;
    
    id<NSObject> delegate;
    SEL colorChosenSelector;
    SEL cancelSelector;
    
    CGFloat hue;
    CGFloat value;
    CGFloat saturation;
    CGFloat alpha;
    UINavigationBar *titleBar;
    NSString *alphaText;
}
@property (nonatomic, retain) IBOutlet UINavigationBar *titleBar;
@property (nonatomic, retain) IBOutlet UIView  *newColorView;
@property (nonatomic, retain) IBOutlet UIView  *theColorChooser;
@property (nonatomic, retain) IBOutlet UIView *colorChooserFrame;
@property (nonatomic, retain) CALayer  *colorChooserLayer;
@property (nonatomic, retain) IBOutlet UILabel *alphaLabel;
@property (nonatomic, retain) IBOutlet UISlider *alphaSlider;
@property (nonatomic, retain) IBOutlet UIView *newMarker;

@property (nonatomic, retain) UIColor *currentColor;
@property (nonatomic, retain) UIColor *choosenColor;
@property (nonatomic, retain) IBOutlet UIImageView *hueImage;
@property (nonatomic, retain) IBOutlet UIImageView *hueSelector;

@property (nonatomic, retain) NSString *alphaText;

@property (nonatomic) CGFloat hue;
@property (nonatomic) CGFloat value;
@property (nonatomic) CGFloat saturation;
@property (nonatomic) CGFloat alpha;

@property (nonatomic, retain) id<NSObject> delegate;
@property (nonatomic) SEL colorChosenSelector;
@property (nonatomic) SEL cancelSelector;

-(id) initWithDelegate:(id) delegate colorChosenSelector:(SEL) colorChosenSelector cancelSelector:(SEL) cancelSelector;

-(IBAction) cancel;
-(IBAction) done;
- (IBAction)alphaChanged:(id)sender;


@end
