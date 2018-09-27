//
//  NativeADViewController.swift
//  com.appodeal.support.test
//
//  Created by andrei zeniukevich on 27/09/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//


//Бонусное задание
//При нажатии на кнопку будет появляться ListView со встроенной нативной рекламой.
//Важно помнить, что для загрузки рекламы требуется время.
//Итогом работы должен быть проект приложения.

import UIKit
import Appodeal

class NativeADViewController: UIViewController, APDNativeAdLoaderDelegate {

    var apdLoader : APDNativeAdLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apdLoader = APDNativeAdLoader.init()
        apdLoader.delegate = self;
        apdLoader.loadAd(with: APDNativeAdType.auto)
    }

    func nativeAdLoader(_ loader: APDNativeAdLoader!, didLoad nativeAds: [APDNativeAd]!){
        NSLog("Нативная реклама была загружена")
    }
    func nativeAdLoader(_ loader: APDNativeAdLoader!, didFailToLoadWithError error: Error!){
        NSLog("Нативной рекламе не удалось загрузиться")
    }
}
