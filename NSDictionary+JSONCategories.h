//
//  NSDictionary+JSONCategories.h
//  ShopCloth
//
//  Created by apple on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//外网
#define kUrlOfInitServices @"http://shopmgr.ucai.com/index.php?uf=pub&um=initShop&key=ucai2012&imsi=1&phone_num=1&app_name=%E5%A5%B3%E8%A3%85&app=shop_clothes&uccode=ucai"
#define kUrlOfBase @"http://shop.ucai.com/pub.php?code="
//版本信息
#define kUrlVersion @"http://app.ucai.com/upload/version/ucshop.html"

//内网
//#define kUrlOfInitServices @"http://192.168.1.188/shopmgrdev/index.php?uf=pub&um=initShop&key=ucai2012&imsi=1&phone_num=1&app_name=%E5%A5%B3%E8%A3%85&app=shop_clothes&uccode=ucai"
//#define kUrlOfBase @"http://192.168.1.188/shopdev/pub.php?code="
////版本信息
//#define kUrlVersion @"http://192.168.1.188/app/version/ucshop.html"

#define kShopCode SharedApp.shopcode
#define kDefaultPageSize 15
#define kDefaultCurrentPage 1
//首页新闻
#define kUrlOfIndexNews [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_home_news"]
//店铺相册
#define kUrlOfShopAlbum [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_album_photos"]
//新品
#define kUrlOfNewGoods [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_recommend_goods&type=new"]
//热卖
#define kUrlOfHotGoods [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_recommend_goods&type=hot"]
//推荐
#define kUrlOfRecommendGoods [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_recommend_goods&type=best"]
//品牌
#define kUrlOfBrands [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_brands"]
//商品分类
#define kUrlOfCategories [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_goods_categories"]
//商品详情
#define kUrlOfGoodsDetail [kUrlOfBase stringByAppendingFormat:@"%@%@%@",kShopCode,@"&act=get_goods_info&id=",self.goodsId]
//商品相册
#define kUrlOfGoodsImgs [kUrlOfBase stringByAppendingFormat:@"%@%@%@",kShopCode,@"&act=good_pics&gid=",self.goodsId]
//友情链接
#define kUrlOfFriendLink [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_friend_links"]
//新闻列表
#define kUrlOfNews [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=index_get_new_articles"]
//新闻详情,必须在使用页面定义newsId属性
#define kUrlOfNewsDetail [kUrlOfBase stringByAppendingFormat:@"%@%@%@",kShopCode,@"&act=get_article_info&id=",self.newsId]
//优惠活动列表
#define kUrlOfActivity [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_promotion_info"]
//优惠活动详情
#define kUrlOfActivityDetail [kUrlOfBase stringByAppendingFormat:@"%@%@%@",kShopCode,@"&act=favourable_info&id=",self.activityId]
//案例
#define kUrlOfCase [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_corp_case"]
//案例详情
#define kUrlOfCaseDetail [kUrlOfBase stringByAppendingFormat:@"%@%@%@",kShopCode,@"&act=get_article_info&id=",self.caseId]
//根据品牌查询某个品牌下的商品
#define kUrlOfGoodsByBrand [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_goods_by_brandid"]
//根据商品分类查询某个分类下的商品
#define kUrlOfGoodsByCategory [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_category_goods"]
//合作伙伴
#define kUrlOfPartners [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=get_friend_links"]
//关于我们
#define kUrlOfAboutUs [kUrlOfBase stringByAppendingFormat:@"%@%@",kShopCode,@"&act=shop_info"]

@interface NSDictionary (JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;
@end
