# yahoo-weather-mirror

模仿雅虎天气的一个简单版本。

## 本项目使用[雅虎天气](wwww.yahoo.com/news/weather/)的api，使用部分雅虎天气的资源。仅个人学习代码，有几点说明。

* 雅虎天气能查询到的免费接口，缺少一部分数据。比如：未来24小时各个时间段的天气情况，紫外线指数等，这一部分暂时使用随机生成。如有人发现更全面的接口，请@我。
* 第三方库，在不是必需的情况下，尽量不使用。目前使用的第三方库，未来（什么时候谁知道呢(⊙o⊙)?）可能使用自己实现的方案代替--!。
* 项目还有一些奇怪的地方：比如自定义View既使用Nib，Storyboard也使用手动代码，给Cell设置相关Model的时候既使用字典传递，也使用过Model传递，页面跳转既使用代码也使用segues方式...
* 这个项目是本着学习的目的写的!!!

## TODOLIST

* 修复Bug

## YQL简单实用文档:
<pre><code>
    YQL* yql = [[YQL alloc] init];
    NSString* queryString  = nil;
    //查询地区的例子
    queryString = @"select * from geo.places where text=\"北京\"";
    queryString = @"select * from geo.places where text=\"ShangHai\"";
    
    // 通过经纬度查询不了(目前貌似查询不了)
    queryString = @"select * from geo.places where text=\"39.9919336,116.3404132\"";

    
    // 查询天气的例子(从前面接口获取城市的whoeid)
    queryString = @"select * from weather.forecast where woeid=2502265";
    
    // 查询更具体的天气信息(风)
    queryString = @"select wind from weather.forecast where woeid=2502265";
    
    // 当前天气状况
    queryString = @"select item.condition from weather.forecast where woeid=2502265";
    
    // 日落信息
    queryString = @"select astronomy.sunset from weather.forecast where woeid=2502265";
    

   	// 以下为通过YQL获取flickr相关接口的例子
    //and geo_context=2
    queryString = @"select * from flickr.photos.search where text=\"厦门\" and api_key=\"You_Api_Key\" and has_geo=\"true\"";
    
    // 图片信息格式(返回的图片节点信息)
    [{
        farm = 8;
        id = 28974031592;
        isfamily = 0;
        isfriend = 0;
        ispublic = 1;
        owner = "143750153@N08";
        secret = 31aa1b1e35;
        server = 7730;
        title = "SummerGo\U53a6\U95e8";
    }]
    通过上面节点拼接出来的图片URL地址：
	// https://farm8/staticflickr.com/7730/28974031592_31aa1b1e35.jpg
    
    
    // 拼装图片URL格式的方法为:https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{mstzb}.jpg
    
    
	//queryString = @"select* from select * from flickr.people.getInfo where user_id=\"143750153@N08\"";
	//NSDictionary* result = [yql query:queryString];
</code></pre>


## 简单展示

![show1](https://github.com/objectobject/yahoo-weather-mirror/raw/master/Preview/xi.png)

![show1](https://github.com/objectobject/yahoo-weather-mirror/raw/master/Preview/an.png)


## 部分图标资源来源说明:
   1. 天气图标来自[MerlinTheRed](http://merlinthered.deviantart.com/art/plain-weather-icons-157162192) 图标版权归原作者所有。
   2. 部分图片资源来自[Yahoo天气](https://www.yahoo.com/news/weather/)iOSapp, 图片版权归原作者所有。
   3. 部分图片资源来自[必应首页](http://cn.bing.com), 图片版权归原作者所有。
   4. 其他图片资源来自网络，图片版权归原作者所有。
