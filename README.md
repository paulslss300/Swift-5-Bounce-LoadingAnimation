# Swift-5-Bounce-LoadingAnimation
## Features
Creates a customizeable loading view with a bouncing image animation.

## How to use it
1. Put:
 `var loadingAnimation = animationView()`
 in ViewController class
 
 2. Set up loadingAnimation by setting up the superView and image (optional):  
 `loadingAnimation.superView = scrollView`
 
 `if let image = UIImage(named: "IMAGE_NAME") {
 loadingAnimation.image = image
 }`
 
 3. Start animation:  
 `loadingAnimation.startAnimation()`
 
 4. Stop animation:  
 `loadingAnimation.stopAnimation()`
