//
//  TOLViewController.m
//  OctaveTest
//
//  Created by Lars Anderson on 1/31/13.
//  Copyright (c) 2013 @theonlylars. All rights reserved.
//

#import "TOLViewController.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, TOLSoundType) {
    TOLSoundTypeSlide,
    TOLSoundTypeBeeps,
    TOLSoundTypeTaps
};

NSString * const kTOLSoundCellIdentifier = @"sound-cell";

@interface TOLViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *soundPlayers;

@end

@implementation TOLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *slides = [NSMutableArray array];
    NSMutableArray *beeps = [NSMutableArray array];
    NSMutableArray *taps = [NSMutableArray array];
    
    NSMutableArray *slideSessions = [NSMutableArray array];
    NSMutableArray *beepSessions = [NSMutableArray array];
    NSMutableArray *tapSessions = [NSMutableArray array];
    
    NSArray *allSounds = [[NSBundle mainBundle] pathsForResourcesOfType:@"aif" inDirectory:nil];
    for (NSString *soundReference in allSounds) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundReference];
        NSError *error = nil;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        [audioPlayer prepareToPlay];
        
        if ([soundReference rangeOfString:@"beep"].length > 0) {
            [beeps addObject:soundReference];
            [beepSessions addObject:audioPlayer];
        } else if ([soundReference rangeOfString:@"slide"].length > 0) {
            [slides addObject:soundReference];
            [slideSessions addObject:audioPlayer];
        } else {
            [taps addObject:soundReference];
            [tapSessions addObject:audioPlayer];
        }
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    self.tableViewData = @[slides, beeps, taps];
    self.soundPlayers = @[slideSessions, beepSessions, tapSessions];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTOLSoundCellIdentifier];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:kTOLSoundCellIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Play sound
    AVAudioPlayer *player = self.soundPlayers[indexPath.section][indexPath.row];
    [player play];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewData[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch ((TOLSoundType)section) {
        case TOLSoundTypeSlide:
            return @"Slides";
            break;
        case TOLSoundTypeBeeps:
            return @"Beeps";
            break;
        case TOLSoundTypeTaps:
            return @"Taps";
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self soundNameFromPath:self.tableViewData[indexPath.section][indexPath.row]];
}


#pragma mark - Helpers

- (NSString *)soundNameFromPath:(NSString *)path
{
    NSString *fileName = [[path lastPathComponent] stringByDeletingPathExtension];
    NSString *soundName = [[fileName componentsSeparatedByString:@"-"] lastObject];
    
    return [soundName capitalizedString];
}

@end
