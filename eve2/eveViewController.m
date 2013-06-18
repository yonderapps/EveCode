//
//  eveViewController.m
//  eve2
//
//  Created by Daniel Pape on 06/05/2013.
//  Copyright (c) 2013 Daniel Pape. All rights reserved.
//

#import "eveViewController.h"
#import "MHRotaryKnob.h"


@interface eveViewController ()
@end

@implementation eveViewController

NSString *hourFormat;
NSString *dialTime;
NSString *alarmNameString;
NSString *reminderTimeString;
NSString *phoneModel;
int hourOfSleep;
BOOL isPlaying;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyleRotating;
	self.rotaryKnob.scalingFactor = 1.5f;
	self.rotaryKnob.maximumValue = 500;
	self.rotaryKnob.minimumValue = -500;
    self.rotaryKnob.defaultValue = 500;
	self.rotaryKnob.value = self.slider.value;
	self.rotaryKnob.resetsToDefault = NO;
    self.rotaryKnob.foregroundImage = [UIImage imageNamed:@"KnobOverlay2.png"];
	self.rotaryKnob.backgroundColor = [UIColor clearColor];
	[self.rotaryKnob setKnobImage:[UIImage imageNamed:@"KnobSky3.png"] forState:UIControlStateNormal];
	self.rotaryKnob.knobImageCenter = CGPointMake(160.0f, 160.0f);
	[self.rotaryKnob addTarget:self action:@selector(rotaryKnobDidChange) forControlEvents:UIControlEventValueChanged];
            
    NSDateFormatter *labelFormat = [[NSDateFormatter alloc] init];
    dialTime = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
        
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH mm a"];
    self.wakeTimeLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:[NSDate date]]];
    
    NSDateFormatter *dateForAlarm = [[NSDateFormatter alloc] init];
    [dateForAlarm setDateFormat:@"HH"];
    NSString *hours = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
    
    [dateForAlarm setDateFormat:@"mm"];
    NSString *minutes = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
    
    float minutesPastHour = [minutes intValue];
    int hoursInt = [hours intValue];
    float minutesPercentage = (minutesPastHour/60) *100;
    
    float Hm = (hoursInt*100)+minutesPercentage;
    NSLog(@"%f",Hm);
    NSLog(@"%f",self.rotaryKnob.value);
    
    CGPoint center = [_skyBack center];
    center.x = 160;
    center.y = Hm - 400;
    [_skyBack setCenter:center];
    
    
    
    hourFormat = @"HH mm a";
    alarmNameString = @"eveAlarm4.wav";
    hourOfSleep = 8;
    self.sleepLengthLabel.text = [NSString stringWithFormat:@"%i hours",hourOfSleep];
    phoneModel = [[UIDevice currentDevice]model];
    isPlaying = NO;
    
    NSLog(@"%@",phoneModel);
    }

- (void)viewDidUnload {
    [self setKnobCentre:nil];
    [super viewDidUnload];
}

- (IBAction) pressIntroScreenButton{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH mm a"];
    self.wakeTimeLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:[NSDate date]]];
    
    NSDateFormatter *dateForAlarm = [[NSDateFormatter alloc] init];
    [dateForAlarm setDateFormat:@"HH"];
    NSString *hours = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
    
    [dateForAlarm setDateFormat:@"mm"];
    NSString *minutes = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
    
    float minutesPastHour = [minutes intValue];
    int hoursInt = [hours intValue];
    float minutesPercentage = (minutesPastHour/60) *100;
    
    float Hm = (hoursInt*100)+minutesPercentage;
    NSLog(@"%f",Hm);
    NSLog(@"%f",self.rotaryKnob.value);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint center = [_skyBack center];
    center.x = 160;
    center.y = Hm - 400;
    [_skyBack setCenter:center];
    [UIView commitAnimations];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.introScreen.alpha = 0;
    [UIView commitAnimations];
}


- (IBAction)rotaryKnobDidChange{
    
    self.setAlarmButton.enabled = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.dragInstructions.alpha=0;
    [UIView commitAnimations];
    
    NSDateFormatter *labelFormat = [[NSDateFormatter alloc] init];
    [labelFormat setDateFormat:hourFormat];
    self.wakeTimeLabel.text = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH"];
    NSString *hours = [dateFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]];
    
    [dateFormat setDateFormat:@"mm"];
    NSString *minutes = [dateFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]];
    
    float minutesPastHour = [minutes intValue];
    NSLog(@"minutes past hour: %@",minutes);
    int hoursInt = [hours intValue];
    float minutesPercentage = (minutesPastHour/60) *100;
    
    float Hm = (hoursInt*100)+minutesPercentage;
    NSLog(@"%f",Hm);
    NSLog(@"Rotary Knob Value: %f",self.rotaryKnob.value);

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    CGPoint center = [_skyBack center];
    center.x = 160;
    center.y = Hm - 400;
    
    [_skyBack setCenter:center];
    
    [UIView commitAnimations];

}

-(IBAction)pressSetAlarmButton{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.dragInstructions.alpha=0;
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.setAlarmButton.alpha = 0;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint center = [self.menuView center];
    center.x = 160;
    if([phoneModel isEqual: @"iPhone 5"]){
        center.y = 495;}else{
    center.y = 405;
        }
    [self.menuView setCenter:center];
    
    self.soundNameLabelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.rotaryKnob.alpha = 0;
    
    CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
    soundNameLabelCenter.x = 160;
    soundNameLabelCenter.y = 80;
    [self.soundNameLabelView setCenter:soundNameLabelCenter];
    
    CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
    sleepLengthLabelCenter.x = 160;
    sleepLengthLabelCenter.y = 150;
    [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
    
    CGPoint setAlarmButtonViewCenter = [self.setAlarmButtonView center];
    setAlarmButtonViewCenter.x = 160;
    setAlarmButtonViewCenter.y = 220;
    [self.setAlarmButtonView setCenter:setAlarmButtonViewCenter];
    
    CGPoint returnSetSettingsViewCenter = [self.returnSetSettingsView center];
    returnSetSettingsViewCenter.x = 160;
    returnSetSettingsViewCenter.y = 290;
    [self.returnSetSettingsView setCenter:returnSetSettingsViewCenter];
    
    CGPoint menuButtonCenter = [self.menuButton center];
    menuButtonCenter.x = 296;
    menuButtonCenter.y = 500;
    [self.menuButton setCenter:menuButtonCenter];
    
    CGPoint closeEveViewCenter = [self.closeEveView center];
    closeEveViewCenter.x = 160;
    closeEveViewCenter.y = 500;
    [self.closeEveView setCenter:closeEveViewCenter];

    [UIView commitAnimations];
}

- (IBAction) setAlarm {
    NSDate *alarmTime = [[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800];
    NSLog(@"alarm time is %@",alarmTime );
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDateComponents *alarmComponent = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit ) fromDate:alarmTime];
    
    NSDateComponents *todayComponent = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit ) fromDate:[NSDate date]];
    
    [alarmComponent setYear:todayComponent.year];
    [alarmComponent setMonth:todayComponent.month];
    [alarmComponent setDay:todayComponent.day];
    [alarmComponent setHour:alarmComponent.hour];
    [alarmComponent setMinute:alarmComponent.minute];
    
    NSDate *provisionalAlarmTime = [calendar dateFromComponents:alarmComponent];
    
    NSComparisonResult result = [provisionalAlarmTime compare:[NSDate date]];
    
    if(result==NSOrderedAscending)
        provisionalAlarmTime = [provisionalAlarmTime dateByAddingTimeInterval:60*60*24];
    else if(result==NSOrderedDescending)
        provisionalAlarmTime = provisionalAlarmTime;
        
    UILocalNotification *wakeAlarm = [[UILocalNotification alloc]init];
    wakeAlarm.fireDate = provisionalAlarmTime;
    wakeAlarm.alertBody = [self wakeMessage];
    wakeAlarm.soundName = alarmNameString;
    
    [wakeAlarm setHasAction:YES];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:wakeAlarm];
    NSLog(@"alarm is set for %@",provisionalAlarmTime);
    
    UILocalNotification *reminderAlarm = [[UILocalNotification alloc]init];
    
    reminderAlarm.fireDate = [provisionalAlarmTime dateByAddingTimeInterval:-hourOfSleep*60*60];
    reminderAlarm.alertBody = @"Feeling sleepy? If you go to bed now, you will feel refreshed & energised in the morning";
    reminderAlarm.soundName = @"sleepAlarm1.wav";
        
    NSComparisonResult reminderResult = [[provisionalAlarmTime dateByAddingTimeInterval:-hourOfSleep*60*60] compare:[NSDate date]];
    
    if(reminderResult==NSOrderedDescending){
        [[UIApplication sharedApplication] scheduleLocalNotification:reminderAlarm];
        NSLog(@"Reminder alarm set for %@",[provisionalAlarmTime dateByAddingTimeInterval:-hourOfSleep*60*60]);
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:hourFormat];
    
    self.reminderTimeLabel.text = [dateFormat stringFromDate:[provisionalAlarmTime dateByAddingTimeInterval:-hourOfSleep*60*60]];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint center = [self.menuView center];
    center.x = 160;
    if([phoneModel isEqual: @"iPhone 5"]){
        center.y = 495;}else{
    center.y = 405;
        };
    [self.menuView setCenter:center];
    
    self.eveWillWakeLabel.alpha = 1;
    
    CGPoint formatLabelCenter = [self.timeFormatLabelView center];
    formatLabelCenter.x = 160;
    formatLabelCenter.y = 500;
    [self.timeFormatLabelView setCenter:formatLabelCenter];
    
    CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
    soundNameLabelCenter.x = 160;
    soundNameLabelCenter.y = 500;
    [self.soundNameLabelView setCenter:soundNameLabelCenter];
    
    CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
    sleepLengthLabelCenter.x = 160;
    sleepLengthLabelCenter.y = 500;
    [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
    
    CGPoint reminderTimeViewCenter = [self.reminderTimeView center];
    reminderTimeViewCenter.x = 160;
    reminderTimeViewCenter.y = 80;
    [self.reminderTimeView setCenter:reminderTimeViewCenter];
        
    CGPoint settingsReturnButtonViewCenter = [self.settingsReturnButtonView center];
    settingsReturnButtonViewCenter.x = 160;
    settingsReturnButtonViewCenter.y = 500;
    [self.settingsReturnButtonView setCenter:settingsReturnButtonViewCenter];

    CGPoint setAlarmButtonViewCenter = [self.setAlarmButtonView center];
    setAlarmButtonViewCenter.x = 160;
    setAlarmButtonViewCenter.y = 500;
    [self.setAlarmButtonView setCenter:setAlarmButtonViewCenter];
    
    CGPoint closeEveViewCenter = [self.closeEveView center];
    closeEveViewCenter.x = 160;
    closeEveViewCenter.y = 290;
    [self.closeEveView setCenter:closeEveViewCenter];

    CGPoint resetButtonViewCenter = [self.resetButtonView center];
    resetButtonViewCenter.x = 160;
    resetButtonViewCenter.y = 220;
    [self.resetButtonView setCenter:resetButtonViewCenter];
    
    CGPoint setToLoudModeViewCenter = [self.setToLoudModeView center];
    setToLoudModeViewCenter.x = 160;
    setToLoudModeViewCenter.y = 150;
    [self.setToLoudModeView setCenter:setToLoudModeViewCenter];
    
    CGPoint returnSetSettingsViewCenter = [self.returnSetSettingsView center];
    returnSetSettingsViewCenter.x = 160;
    returnSetSettingsViewCenter.y = 500;
    [self.returnSetSettingsView setCenter:returnSetSettingsViewCenter];
    
    
    [UIView commitAnimations];
    [_audioPlayer stop];
    
}

- (IBAction) pressSettingsButton{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.setAlarmButton.alpha = 0;
    self.dragInstructions.alpha = 0;
        [UIView commitAnimations];
    
    self.soundNameLabelView.backgroundColor = [UIColor colorWithRed:36/255.0f green:36/255.0f blue:36/255.0f alpha:1.0f];
    
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGPoint center = [self.menuView center];
        center.x = 160;
    
    if([[[UIDevice currentDevice]model] isEqual: @"iPhone 5"]){
        center.y = 495;
    }else{
        center.y = 405;
    }
        [self.menuView setCenter:center];
        
        CGPoint menuButtonCenter = [self.menuButton center];
        menuButtonCenter.x = 296;
        menuButtonCenter.y = 500;
        [self.menuButton setCenter:menuButtonCenter];
        
        CGPoint formatLabelCenter = [self.timeFormatLabelView center];
        formatLabelCenter.x = 160;
        formatLabelCenter.y = 80;
        [self.timeFormatLabelView setCenter:formatLabelCenter];
        
        CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
        soundNameLabelCenter.x = 160;
        soundNameLabelCenter.y = 150;
        [self.soundNameLabelView setCenter:soundNameLabelCenter];
        
        CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
        sleepLengthLabelCenter.x = 160;
        sleepLengthLabelCenter.y = 220;
        [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
        
        CGPoint settingsReturnButtonViewCenter = [self.settingsReturnButtonView center];
        settingsReturnButtonViewCenter.x = 160;
        settingsReturnButtonViewCenter.y = 290;
        [self.settingsReturnButtonView setCenter:settingsReturnButtonViewCenter];
    
        CGPoint closeEveViewCenter = [self.closeEveView center];
        closeEveViewCenter.x = 160;
        closeEveViewCenter.y = 500;
        [self.closeEveView setCenter:closeEveViewCenter];
    
    self.rotaryKnob.alpha = 0;
        
        [UIView commitAnimations];
        
    }
    
- (IBAction)pressSettingsReturnButton{

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGPoint center = [self.menuView center];
        center.x = 160;
    
    if([[[UIDevice currentDevice]model] isEqual: @"iPhone 5"]){
        center.y = 670;
    }else{
        center.y = 585;
    }
        
        [self.menuView setCenter:center];
    
        CGPoint menuButtonCenter = [self.menuButton center];
        menuButtonCenter.x = 296;
        menuButtonCenter.y = 120;
        [self.menuButton setCenter:menuButtonCenter];
    
        CGPoint formatLabelCenter = [self.timeFormatLabelView center];
        formatLabelCenter.x = 160;
        formatLabelCenter.y = 500;
        [self.timeFormatLabelView setCenter:formatLabelCenter];
        
        CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
        soundNameLabelCenter.x = 160;
        soundNameLabelCenter.y = 500;
        [self.soundNameLabelView setCenter:soundNameLabelCenter];
        
        CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
        sleepLengthLabelCenter.x = 160;
        sleepLengthLabelCenter.y = 500;
        [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
    
        CGPoint closeEveViewCenter = [self.closeEveView center];
        closeEveViewCenter.x = 160;
        closeEveViewCenter.y = 500;
        [self.closeEveView setCenter:closeEveViewCenter];
    
        [UIView commitAnimations];
    
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.setAlarmButton.alpha = 1;

        [UIView commitAnimations];
    
    NSLog(@"Menu Button X = %f, Menu Button Y = %f", menuButtonCenter.x,menuButtonCenter.y);

    
    self.rotaryKnob.alpha = 0.4;

    [_audioPlayer stop];
    }
- (IBAction) pressReturnSetSettingsButton{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint center = [self.menuView center];
    center.x = 160;
    if([[[UIDevice currentDevice]model] isEqual: @"iPhone 5"]){
        center.y = 670;
    }else{
        center.y = 585;
    }
    [self.menuView setCenter:center];
    
    CGPoint menuButtonCenter = [self.menuButton center];
    menuButtonCenter.x = 296;
    menuButtonCenter.y = 120;
    [self.menuButton setCenter:menuButtonCenter];
    
    CGPoint formatLabelCenter = [self.timeFormatLabelView center];
    formatLabelCenter.x = 160;
    formatLabelCenter.y = 500;
    [self.timeFormatLabelView setCenter:formatLabelCenter];
    
    CGPoint setAlarmButtonViewCenter = [self.setAlarmButtonView center];
    setAlarmButtonViewCenter.x = 160;
    setAlarmButtonViewCenter.y = 500;
    [self.setAlarmButtonView setCenter:setAlarmButtonViewCenter];
    
    CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
    soundNameLabelCenter.x = 160;
    soundNameLabelCenter.y = 500;
    [self.soundNameLabelView setCenter:soundNameLabelCenter];
    
    CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
    sleepLengthLabelCenter.x = 160;
    sleepLengthLabelCenter.y = 500;
    [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
    [UIView commitAnimations];
    
    CGPoint closeEveViewCenter = [self.closeEveView center];
    closeEveViewCenter.x = 160;
    closeEveViewCenter.y = 500;
    [self.closeEveView setCenter:closeEveViewCenter];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.setAlarmButton.alpha = 1;
    
    [UIView commitAnimations];

    self.rotaryKnob.alpha = 0.4;
    [_audioPlayer stop];
}


- (IBAction)changeHourFormat{
    if([hourFormat isEqual: @"HH mm a"]){
        hourFormat = @"h mm a";
        NSDateFormatter *labelFormat = [[NSDateFormatter alloc] init];
        [labelFormat setDateFormat:hourFormat];
        self.wakeTimeLabel.text = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
        self.menuHourFormatLabel.text = @"12 hour";
    }else if([hourFormat isEqual:@"h mm a"]){
        hourFormat = @"HH mm a";
        NSDateFormatter *labelFormat = [[NSDateFormatter alloc] init];
        [labelFormat setDateFormat:hourFormat];
        self.wakeTimeLabel.text = [NSString stringWithFormat:@"%@", [labelFormat stringFromDate:[[NSDate date] dateByAddingTimeInterval: self.rotaryKnob.value*800]]];
        self.menuHourFormatLabel.text = @"24 hour";

    }
}

- (IBAction) nextAlarm{
    
    if ([alarmNameString isEqual: @"eveAlarm1.wav"]) {
        alarmNameString = @"eveAlarm2.wav";
        [self.soundButton setTitle:@"Ludwig" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }else if ([alarmNameString isEqual: @"eveAlarm2.wav"]){
        alarmNameString = @"eveAlarm3.wav";
        NSLog(@"alarm name is %@",alarmNameString);
        [self.soundButton setTitle:@"Orient" forState:UIControlStateNormal];
    }else if ([alarmNameString isEqual: @"eveAlarm3.wav"]){
        alarmNameString = @"eveAlarm4.wav";
        [self.soundButton setTitle:@"Cassius" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }else if ([alarmNameString isEqual: @"eveAlarm4.wav"]){
        alarmNameString = @"eveAlarm1.wav";
        [self.soundButton setTitle:@"Module" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }
    
    [_audioPlayer stop];
    isPlaying = NO;
}

- (IBAction) prevAlarm{
    
    if ([alarmNameString isEqual: @"eveAlarm1.wav"]) {
        alarmNameString = @"eveAlarm4.wav";
        [self.soundButton setTitle:@"Cassius" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }else if ([alarmNameString isEqual: @"eveAlarm4.wav"]){
        alarmNameString = @"eveAlarm3.wav";
        NSLog(@"alarm name is %@",alarmNameString);
        [self.soundButton setTitle:@"Orient" forState:UIControlStateNormal];
    }else if ([alarmNameString isEqual: @"eveAlarm3.wav"]){
        alarmNameString = @"eveAlarm2.wav";
        [self.soundButton setTitle:@"Ludwig" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }else if ([alarmNameString isEqual: @"eveAlarm2.wav"]){
        alarmNameString = @"eveAlarm1.wav";
        [self.soundButton setTitle:@"Module" forState:UIControlStateNormal];
        NSLog(@"alarm name is %@",alarmNameString);
    }
    
    [_audioPlayer stop];
    isPlaying  = NO;
}

- (IBAction) pressSoundButton{
   /* if(isPlaying == NO){CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"eveAlarm1", CFSTR ("wav"), NULL);
    
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
        isPlaying = YES;
    */
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],alarmNameString]];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    if(isPlaying == NO){
        [_audioPlayer play];
        isPlaying = YES;
    }else if(isPlaying == YES){
        [_audioPlayer stop];
        isPlaying = NO;
    }
    }


- (IBAction) moreHours{
    if(hourOfSleep <=11)hourOfSleep++;
    self.sleepLengthLabel.text = [NSString stringWithFormat:@"%i hours",hourOfSleep];
}

- (IBAction) lessHours{
    if(hourOfSleep >= 2)hourOfSleep--;
    self.sleepLengthLabel.text = [NSString stringWithFormat:@"%i hours",hourOfSleep];
}

- (IBAction) pressResetButton{
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    NSLog(@"Alarms Cancelled");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGPoint center = [self.menuView center];
    center.x = 160;
    if([[[UIDevice currentDevice]model] isEqual: @"iPhone 5"]){
        center.y = 670;
    }else{
        center.y = 585;
    }
    [self.menuView setCenter:center];
    
    self.eveWillWakeLabel.alpha = 0;
    
    CGPoint menuButtonCenter = [self.menuButton center];
    menuButtonCenter.x = 296;
    menuButtonCenter.y = 120;
    [self.menuButton setCenter:menuButtonCenter];
    
    CGPoint setAlarmButtonViewCenter = [self.setAlarmButtonView center];
    setAlarmButtonViewCenter.x = 160;
    setAlarmButtonViewCenter.y = 500;
    [self.setAlarmButtonView setCenter:setAlarmButtonViewCenter];
    
    CGPoint formatLabelCenter = [self.timeFormatLabelView center];
    formatLabelCenter.x = 160;
    formatLabelCenter.y = 500;
    [self.timeFormatLabelView setCenter:formatLabelCenter];
    
    CGPoint soundNameLabelCenter = [self.soundNameLabelView center];
    soundNameLabelCenter.x = 160;
    soundNameLabelCenter.y = 500;
    [self.soundNameLabelView setCenter:soundNameLabelCenter];
    
    CGPoint sleepLengthLabelCenter = [self.sleepLengthLabelView center];
    sleepLengthLabelCenter.x = 160;
    sleepLengthLabelCenter.y = 500;
    [self.sleepLengthLabelView setCenter:sleepLengthLabelCenter];
    
    CGPoint reminderTimeViewCenter = [self.reminderTimeView center];
    reminderTimeViewCenter.x = 160;
    reminderTimeViewCenter.y = 500;
    [self.reminderTimeView setCenter:reminderTimeViewCenter];

    self.setAlarmButton.alpha = 1;
    
    CGPoint resetButtonViewCenter = [self.resetButtonView center];
    resetButtonViewCenter.x = 160;
    resetButtonViewCenter.y = 500;
    [self.resetButtonView setCenter:resetButtonViewCenter];
    
    CGPoint setToLoudModeViewCenter = [self.setToLoudModeView center];
    setToLoudModeViewCenter.x = 160;
    setToLoudModeViewCenter.y = 500;
    [self.setToLoudModeView setCenter:setToLoudModeViewCenter];
    
    CGPoint closeEveViewCenter = [self.closeEveView center];
    closeEveViewCenter.x = 160;
    closeEveViewCenter.y = 500;
    [self.closeEveView setCenter:closeEveViewCenter];
    
    [UIView commitAnimations];
    
    self.rotaryKnob.alpha = 0.4;

}

-(NSString *) wakeMessage
{
    NSString* wakeMessageString;
    NSArray* wakeMessageArr = [NSArray arrayWithObjects: @"Good Morning! An early-morning walk is a blessing for the whole day, according to Henry David Thoreau",
                        @"Think in the morning, act in the noon, eat in the evening, sleep in the night - Sound advice from William Blake", @"Each morning when I awake, I exprience again a supreme pleasure: That of being Salvador Dali - Wise words from Salvador Dali", @"Lose an hour in the morning and you will spend all day looking for it - Richard Whately!", @"When I wake up in the morning, I feel just like any other insecure 24-year-old girl - Lady Gaga",
                        @"I became a musician so I didn't have to wake up at 6 in the morning - Norah Jones", @"I get up in the morning, looking for an adventure - George Foreman!", nil];
    NSUInteger randomIndex = arc4random() % [wakeMessageArr count];
    wakeMessageString = [wakeMessageArr objectAtIndex: randomIndex];
    return wakeMessageString;
}

-(IBAction) knobEnabled{
    self.setAlarmButton.enabled = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
