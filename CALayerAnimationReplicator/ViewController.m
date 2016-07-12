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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
