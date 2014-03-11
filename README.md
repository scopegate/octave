Octave
======
_A free library of UI sounds, handmade for iOS_  
http://www.raisedbeaches.com/octave

## Why Octave?
Few mobile apps make use of user interface sounds. Whether through lack of time, expertise or interest, not enough developers make use of it. Good sound can enhance usability and draw people into your app, just like well-considered UI or a beautiful icon.

Many developers lack the tools or knowledge to do sound well, and most free sound libraries suck. So we figured we'd make it easy for you, and put together a free pack of beautiful, simple sounds that can be used wherever you like.

## What's included?
- 48 hand-crafted sounds - taps, beeps & slides - designed for user interfaces, and saved as 16 bit, 44.1khz .aifs
- A Sound category for UIControl, that makes the use of UI sounds on iOS as easy as: ```[myControl setSoundNamed:@"mySound.aif" forControlEvent:UIControlEventsTouchUpInside]```
- If you're new to working with sound, it might be worth checking out [our tips](http://www.raisedbeaches.com/octave/tips.html) for some things to think about before you start.

## UIControl+Sound
UIControl+Sound declares a category on UIControl that uses the magic of [associative references](http://oleb.net/blog/2011/05/faking-ivars-in-objc-categories-with-associative-references/) to allow you to create an AVAudioPlayer simply by calling:

````[myControl setSoundNamed:@"mySound.aif" forControlEvent:UIControlEventTouchUpInside]````

This method is _very_ convenient (no need to deal with instantiating AVAudioPlayers, calling ````addTarget:```` on your audioPlayer's  ````play```` method for each sound) for the odd one-off sound, but it's probably a little bit leaky, and it's inefficient if you're playing the same sound on a number of different controls.

## Questions? Problems?
email octave@raisedbeaches.com
