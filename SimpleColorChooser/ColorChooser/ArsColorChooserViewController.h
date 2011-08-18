//
//  ArsColorChooserViewController.h
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArsColorChooserViewController : UIViewController {

    UILabel *titleLabel;
    UIView  *currentColorView;
    UIView  *newColorView;
    
    UIView  *theColorChooser;
    UILabel *valueLabel;
    UILabel *alphaLabel;
    UISlider *valueSlider;
    UISlider *alphaSlider;
    UIView *newMarker;
    UIView *currentMarker;
    
    UIColor *currentColor;
    UIColor *choosenColor;
    
    id<NSObject> delegate;
    SEL colorChosenSelector;
    SEL cancelSelector;
    
    CGFloat value;
    CGFloat alpha;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView  *currentColorView;
@property (nonatomic, retain) IBOutlet UIView  *newColorView;
@property (nonatomic, retain) IBOutlet UIView  *theColorChooser;
@property (nonatomic, retain) IBOutlet UILabel *valueLabel;
@property (nonatomic, retain) IBOutlet UILabel *alphaLabel;
@property (nonatomic, retain) IBOutlet UISlider *valueSlider;
@property (nonatomic, retain) IBOutlet UISlider *alphaSlider;
@property (nonatomic, retain) IBOutlet UIView *newMarker;
@property (nonatomic, retain) IBOutlet UIView *currentMarker;

@property (nonatomic, retain) UIColor *currentColor;
@property (nonatomic, retain) UIColor *choosenColor;

@property (nonatomic) CGFloat value;
@property (nonatomic) CGFloat alpha;

@property (nonatomic, retain) id<NSObject> delegate;
@property (nonatomic) SEL colorChosenSelector;
@property (nonatomic) SEL cancelSelector;

-(id) initWithDelegate:(id) delegate colorChosenSelector:(SEL) colorChosenSelector cancelSelector:(SEL) cancelSelector;

-(IBAction) cancel;
-(IBAction) done;
- (IBAction)valueChanged:(id)sender;
- (IBAction)alphaChanged:(id)sender;


-(void) colorChoosen:(id) sender;

@end
