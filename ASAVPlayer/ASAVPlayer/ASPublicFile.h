//
//  ASPublicFile.h
//  ArtSee
//
//  Created by 韩智星 on 16/10/12.
//  Copyright © 2016年 韩智星. All rights reserved.
//

#ifndef ASPublicFile_h
#define ASPublicFile_h
//weakSelf
#define k_weak(weakSelf) __weak __typeof__(self) weakSelf = self
//尺寸
#define k_size(width,height) CGSizeMake(width, height)
//颜色
#define RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define k_whiteColor [UIColor whiteColor]
//屏幕真实宽高
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define CURRENT_DEVICE_NUM @"11.004"//启动图版本号也要改
//360.00 640.00 6p物理尺寸
//标注宽高1334*/2
#define TScreenH 667.00
#define TScreenW 375.00
#pragma mark - 常用头文件引入
//常用头文件引入
//#import "ASSDKPublic.h"
//#import "ASClassExtendPublic.h"
////#import "ASViewPublic.h"
//#import "ASControllerPublic.h"
//#import "ASURLPublic.h"
#import "MyControl.h"
#import "UIView+viewSet.h"
#import "UIButton+buttonSet.h"
#pragma mark - 自定义宏
//自定义宏
#define k_makeFloat CGFloat viewX = 0,viewY = 0,viewW = 0,viewH = 0
#define set_frame(viewX,viewY,viewW,viewH) (CGRect){viewX,viewY,viewW,viewH}//设置坐标(可修改)
#define set_standard_frame (CGRect){viewX,viewY,viewW,viewH}//设置坐标(固定模式)
#define image(image) [UIImage imageNamed:image]//图片
#define font(int) [UIFont systemFontOfSize:int]//字体大小
#define maxX(rect) CGRectGetMaxX(rect)//最大x
#define maxY(rect) CGRectGetMaxY(rect)//最大y
#define minX(rect) CGRectGetMinX(rect)//最小x
#define minY(rect) CGRectGetMinY(rect)//最小y
#define ASBriefInfoStr @"艺见文化传媒（北京）有限公司以文化、艺术为内容打造的平台，以艺术见解、传播文化，服务大众作为平台方向，艺见是您品味艺术分享思想的首选。有见解共分享，让艺术走进大众不再遥不可及。"
#define ASShareStr @"精彩的世界，不同的见解。在这里与你开启艺术之旅"
#define ASAgreeStr @"艺次元app尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，艺次元app会按照本隐私权政策的规定使用和披露您的个人信息。但艺次元app将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，艺次元app不会将这些信息对外披露或向第三方提供。艺次元app会不时更新本隐私权政策。 您在同意艺次元app服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于艺次元app服务使用协议不可分割的一部分。\n1. 适用范围 \na) 在您使用艺次元app网络服务，或访问艺次元app平台网页时，艺次元app自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；\nb) 艺次元app通过合法途径从商业伙伴处取得的用户个人数据。 \n2. 信息使用\na) 艺次元app不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和艺次元app（含艺次元app关联公司）单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。\nb) 艺次元app亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何艺次元app平台用户如从事上述活动，一经发现，我司有权立即终止与该用户的服务协议。\nc) 为服务用户的目的，艺次元app可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与我司合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。\n3. 信息披露 \n在如下情况下，艺次元app将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息\na) 经您事先同意，向第三方披露；\nb) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\nc) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\nd) 如您出现违反中国有关法律、法规或者艺次元app服务协议或相关规则的情况，需要向第三方披露；\ne) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；nf) 在艺次元app平台上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，艺次元app有权决定向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决。\ng) 其它艺次元app根据法律、法规或者网站政策认为合适的披露。\n4. 信息存储和交换\n艺次元app收集的有关您的信息和资料将保存在艺次元app及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或艺次元app收集信息和资料所在地的境外并在境外被访问、存储和展示。 \n5. 信息安全\na) 艺次元app帐号均有安全保护功能，请妥善保管您的用户名及密码信息。艺次元app将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。\nb) 在使用艺次元app网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是艺次元app用户名及密码发生泄露，请您立即联络艺次元app客服，以便艺次元app采取相应措施。"
#endif /* ASPublicFile_h */
