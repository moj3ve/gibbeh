//import needed headers
#import <SpringBoard/SpringBoard.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <libactivator/libactivator.h>


      //declare needed variables
      UITapGestureRecognizer *tap;
      UIImageView *gibbehImage;
    	UIWindow *gibbehWindow;
      AVAudioPlayer *player;


      //Sound path
    	NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/Gibbeh/"] pathForResource:@"gibbeh" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];



      @interface GibbehActivator :  NSObject <LAListener>
       -(void)noMoreGibbeh;
      @end


      @implementation GibbehActivator
      - (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {


        //function to be executed when user tapped on the screen
      	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noMoreGibbeh)];


        [self noMoreGibbeh];


      	//show gibbeh
      	gibbehWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      	gibbehImage.center = gibbehWindow.center;
      	gibbehWindow.backgroundColor = [UIColor clearColor];
      	gibbehImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Gibbeh/gibbeh.png"]];
      	gibbehWindow.hidden = NO;
      	[gibbehWindow addSubview: gibbehImage];
      	[gibbehWindow addGestureRecognizer:tap];

        //play gibbeh sound
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        player.numberOfLoops = 0;
        player.volume = 1;
      	[player play];

        [event setHandled:YES];

      }


      //remaining things for activator
      - (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
      	return @"Gibbeh!!";
      }
      - (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
      	return @"Make Gibbeh appear!";
      }
      - (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
      	return [NSArray arrayWithObjects:@"springboard", nil];
      }



      + (void)load {
      	[[LAActivator sharedInstance] registerListener:[self new] forName:@"me.memor1es.gibbeh"];
      }


      //function to hide gibbeh and stop audio
      - (void)noMoreGibbeh {
        gibbehWindow.alpha = 0;
        gibbehImage.alpha = 0;
        [gibbehWindow removeFromSuperview];
        [gibbehImage removeFromSuperview];

        [player stop];
      }


      @end
