//
//  UIButton+Sound.h
//  UIButtonSound
//
//  Created by Fred Showell on 6/01/13.
//  Copyright (c) 2013 Fred Showell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIButton (Sound)

-(void) addSoundTitled: (NSString*) soundfilename forUIControlEvent: (UIControlEvents) controlEvents;

@property (nonatomic, strong) AVAudioPlayer* tapSound;
@property (nonatomic, strong) AVAudioPlayer* releaseSound;


@end
