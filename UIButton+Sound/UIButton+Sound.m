//
//  UIButton+Sound.m
//  UIButtonSound
//
//  Created by Fred Showell on 6/01/13.
//  Copyright (c) 2013 Fred Showell. All rights reserved.
//

#import "UIButton+Sound.h"
#import <objc/runtime.h>

static char const * const kTapSoundKey = "kTapSoundKey";
static char const * const kReleaseSoundKey = "kReleaseSoundKey";

@implementation UIButton (Sound)

-(void) addSoundTitled: (NSString*) filename forUIControlEvent: (UIControlEvents) controlEvents
{
    //set appropriate category for UI sounds - do not mute other playing audio
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    NSString *file = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;

    if (controlEvents == UIControlEventTouchDown)
    {
          
        self.tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        [self.tapSound prepareToPlay];
        
        if (error){
            NSLog(@"couldn't add sound - error: %@", error);
        }
        
        else
            
        [self addTarget:self.tapSound action:@selector(play) forControlEvents:controlEvents];
    }
    
    else if (controlEvents == UIControlEventTouchUpInside)
    {
        self.releaseSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        [self.releaseSound prepareToPlay];
        
        if (error){
            NSLog(@"couldn't add sound - error: %@", error);
        }
        
        else

            [self addTarget:self.releaseSound action:@selector(play) forControlEvents:controlEvents];
    }

}


#pragma mark - Associated objects setters/getters

-(void) setTapSound:(AVAudioPlayer *)tapSound
{
    objc_setAssociatedObject(self, kTapSoundKey, tapSound, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) setReleaseSound:(AVAudioPlayer *)releaseSound
{
    objc_setAssociatedObject(self, kReleaseSoundKey, releaseSound, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AVAudioPlayer*) tapSound
{
    return objc_getAssociatedObject(self, kTapSoundKey);
}

-(AVAudioPlayer*) releaseSound
{
    return objc_getAssociatedObject(self, kReleaseSoundKey);
}


@end
