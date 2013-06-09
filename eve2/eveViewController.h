//
//  eveViewController.h
//  eve2
//
//  Created by Daniel Pape on 06/05/2013.
//  Copyright (c) 2013 Daniel Pape. All rights reserved.
//
@class MHRotaryKnob;



#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface eveViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *knobCentre;
@property (nonatomic, weak) IBOutlet MHRotaryKnob *rotaryKnob;
@property (weak, nonatomic) IBOutlet UIImageView *skyBack;
@property (retain, nonatomic) IBOutlet UILabel *wakeTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *setAlarmButton;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *menuHourFormatLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepLengthLabel;
@property (weak, nonatomic) IBOutlet UIView *timeFormatLabelView;
@property (weak, nonatomic) IBOutlet UIView *soundNameLabelView;
@property (weak, nonatomic) IBOutlet UIView *sleepLengthLabelView;
@property (weak, nonatomic) IBOutlet UIButton *setFinalAlarmButton;
@property (weak, nonatomic) IBOutlet UILabel *reminderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eveWillRemindYouTest;
@property (weak, nonatomic) IBOutlet UILabel *setPhoneToLoudModeLabel;
@property (weak, nonatomic) IBOutlet UIView *settingsReturnButtonView;
@property (weak, nonatomic) IBOutlet UIView *setAlarmButtonView;
@property (weak, nonatomic) IBOutlet UIView *resetButtonView;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIView *reminderTimeView;
@property (weak, nonatomic) IBOutlet UIView *setToLoudModeView;
@property (weak, nonatomic) IBOutlet UIView *returnSetSettingsView;
@property (weak, nonatomic) IBOutlet UIButton *returnSetSettingsButton;
@property (weak, nonatomic) IBOutlet UIView *closeEveView;
@property (weak, nonatomic) IBOutlet UIImageView *dragInstructions;
@property (weak, nonatomic) IBOutlet UILabel *eveWillWakeLabel;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *introScreen;

- (IBAction)rotaryKnobDidChange;
- (IBAction) setAlarm;
- (IBAction) pressSettingsButton;
- (IBAction)changeHourFormat;
- (IBAction) nextAlarm;
- (IBAction) prevAlarm;
- (IBAction) moreHours;
- (IBAction) lessHours;
- (IBAction) pressSetAlarmButton;
- (IBAction) pressSettingsReturnButton;
- (IBAction) pressResetButton;
- (IBAction) pressReturnSetSettingsButton;
- (IBAction) pressSoundButton;
- (IBAction) pressIntroScreenButton;


@end
