//
//  ViewController.m
//  Demo
//
//  Created by Yuki on 2020/6/19.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>//Apple 登录权限
@interface ViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];//创建界面
}

/**  创建界面  **/
- (void)buildUI{
    /**  创建按钮  **/
    ASAuthorizationAppleIDButton *appleSinBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleBlack];
    appleSinBtn.frame = CGRectMake(100, 100, 40, 40);
    appleSinBtn.clipsToBounds = YES;
    appleSinBtn.layer.cornerRadius = 20;
    [appleSinBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appleSinBtn];
}

- (void)signBtnClick:(ASAuthorizationAppleIDButton *)sender{
    if (@available(iOS 13.0,*)) {
        //基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc]init];
        
        //创建新的AppleID授权请求
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        
        //在用户授权期间请求的联系信息
        request.requestedScopes = @[ASAuthorizationScopeEmail,ASAuthorizationScopeFullName];
        
        //由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *vc = [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[request]];
        vc.delegate = self;
        vc.presentationContextProvider = self;
        [vc performRequests];
    }else{
        NSLog(@"system is lower");
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error{
    /**  授权失败  **/
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            NSLog(@"取消授权了");
            break;
        case ASAuthorizationErrorUnknown:
            NSLog(@"授权出现未知错误");
            break;
        case ASAuthorizationErrorInvalidResponse:
            NSLog(@"授权请求无响应");
            break;
            
        case ASAuthorizationErrorNotHandled:
            NSLog(@"授权请求未能处理");
            break;
        case ASAuthorizationErrorFailed:
            NSLog(@"授权请求失败");
            break;
        default:
            break;
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    /**  授权成功  **/
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        //用户登录使用 ASAuthorizationAppleIDCredential
        NSLog(@"用户登录使用 ASAuthorizationAppleIDCredential");
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        NSString *user = credential.user;
        NSData *identityToken = credential.identityToken;
        NSLog(@"授权完成");
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        //用户登录使用 ASPasswordCredential
        NSLog(@"用户登录使用 ASPasswordCredential");
        ASPasswordCredential *credential = authorization.credential;
        NSString *user = credential.user;
        NSString *psd = credential.password;
        NSLog(@"授权完成");
    }else {
        NSLog(@"授权信息不符");
    }
}
@end
