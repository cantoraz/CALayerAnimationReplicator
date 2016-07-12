//
//  ViewController.m
//  CALayerAnimationReplicator
//
//  Created by Cantoraz Chou on 7/12/16.
//
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIView* replicatorAnimationView;
@property (weak, nonatomic) IBOutlet UIView* activityIndicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Prepare a replicator CALayer
    CAReplicatorLayer* replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    replicatorLayer.bounds = _replicatorAnimationView.bounds;
//    replicatorLayer.backgroundColor = [UIColor blackColor].CGColor;
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [_replicatorAnimationView.layer addSublayer:replicatorLayer];
    
    // Prepare a prototype CALayer to be replicated
    CALayer* rectangle = [[CALayer alloc] init];
    rectangle.anchorPoint = CGPointMake(0, 0);
    rectangle.bounds = CGRectMake(0, 0, 24, 93);
    rectangle.position = CGPointMake(7, 93);
    rectangle.cornerRadius = 2;
    rectangle.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:rectangle];
    
    // Add animation to the prototype CALayer
    CABasicAnimation* moveRectangle = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveRectangle.toValue = @(rectangle.position.y - 86);
    moveRectangle.duration = .7;
    moveRectangle.autoreverses = true;
    moveRectangle.repeatCount = HUGE;
    [rectangle addAnimation:moveRectangle forKey:nil];
    
    // Replicate the prototype CALayer in the replicator CALayer
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(31, 0, 0);
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.masksToBounds = true;
    
    //--------------------Activity-Indicator--------------------

    // Prepare a CALayer replicator
    CAReplicatorLayer* activityReplicatorLayer = [[CAReplicatorLayer alloc] init];
    activityReplicatorLayer.bounds = _activityIndicatorView.bounds;
    activityReplicatorLayer.position = CGPointMake(_activityIndicatorView.bounds.size.width/2,
                                                   _activityIndicatorView.bounds.size.height/2);
//    activityReplicatorLayer.backgroundColor = [UIColor blackColor].CGColor;
    activityReplicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [_activityIndicatorView.layer addSublayer:activityReplicatorLayer];
    
    // Prepare a prototype CALayer to be replicated
    CALayer* circle = [[CALayer alloc] init];
    circle.bounds = CGRectMake(0, 0, 10, 10);
    circle.position = CGPointMake(activityReplicatorLayer.bounds.size.width/2,
                                  activityReplicatorLayer.bounds.size.height/2 - 40);
    circle.cornerRadius = 5;
    circle.backgroundColor = [UIColor whiteColor].CGColor;
    [activityReplicatorLayer addSublayer:circle];

    // Replicate the prototype CALayer in the replicator CALayer
    activityReplicatorLayer.instanceCount = 15;
    CGFloat angle = 2 * M_PI / activityReplicatorLayer.instanceCount;
    activityReplicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    // Add animation to the prototype CALayer
    CABasicAnimation* scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @0;
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [circle addAnimation:scale forKey:nil];
    
    // Set delay between replicated instances
    activityReplicatorLayer.instanceDelay = 1./15;
    
    // Set the initial scale
    circle.transform = CATransform3DMakeScale(0, 0, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
