//
//  ViewController.swift
//  com.appodeal.support.test
//
//  Created by andrei zeniukevich on 26/09/2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

//Зарегистрируйтесь в www.appodeal.com и загрузите Appodeal SDK для iOS.
//Создайте приложение с bundle com.appodeal.support.test, в которое нужно
//интегрировать Appodeal SDK следующим образом:
//Приложение:
//1) В приложении есть кнопка по центру экрана
//2) По прошествии 30 секунд после запуска, необходимо показать Static Interstitial.
//Показывать каждые 30 секунд. Если кнопка была нажата в первые 30 секунд, то
//показа не должно быть вообще. Время до показа Static Interstitial нужно выводить
//(должен работать счетчик). На Время показа Static Interstitial таймер нужно
//приостанавливать.
//3) Сразу же после запуска показать баннер сверху, и скрыть через 5 секунд после
//того, как баннер будет показан. Больше баннер не показывать.

import UIKit
import Appodeal

class ViewController: UIViewController, AppodealBannerDelegate, AppodealInterstitialDelegate {
    
    var isButtonWasPressed = false
    var isFirst = true
    var countdownTimer: Timer!
    var showInterstitialDelay = 30.0
    var showBannerDuration = 5.0
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isButtonWasPressed == false && isFirst == true {
            isButtonWasPressed = true
            timerLabel.isHidden = true
            button.setTitle("Tapped", for: .normal)
        }
    }
    
    @IBAction func listViewButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Appodeal.setBannerDelegate(self)
        Appodeal.setInterstitialDelegate(self)
        
        showBannerIn(position: .bannerTop, withDuration: showBannerDuration)
        showInterstitialWithDelay(delay: showInterstitialDelay)
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        button.setTitle("Untapped", for: .normal)
    }
    
    //MARK: - Ad show methods
    
    func showBannerIn(position: AppodealShowStyle, withDuration sec: Double) {
        Appodeal.showAd(position, rootViewController: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + sec, execute: {
            Appodeal.hideBanner()
        })
    }
    
    func showInterstitialWithDelay(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.isButtonWasPressed == false {
                Appodeal.showAd(.interstitial, rootViewController: self)
            }
        }
    }
    
    // MARK: - Timer
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(Int(showInterstitialDelay)))"
        
        if showInterstitialDelay != 0 {
            showInterstitialDelay -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }


    // MARK: - AppodealBannerDelegate
    
    func bannerDidLoadAdIsPrecache(_ precache: Bool){
        NSLog("баннер был загружен")
    }
    func bannerDidFailToLoadAd(){
        NSLog("баннеру не удалось загрузиться");
    }
    func bannerDidClick(){
        NSLog("баннер был кликнут")
    }
    func bannerDidShow(){
        NSLog("баннер был показан")
    }
    
    // MARK: -- AppodealInterstitialDelegate --

    func interstitialDidLoadAdisPrecache(_ precache: Bool){
        NSLog("Полноэкранная реклама была загружена")
    }
    func interstitialDidFailToLoadAd(){
        NSLog("Полноэкранной рекламе не удалось загрузиться")
    }
    func interstitialWillPresent(){
        endTimer()
        showInterstitialDelay = 30
        NSLog("Полноэкранная реклама сейчас будет показана")
    }
    func interstitialDidDismiss(){
        showInterstitialWithDelay(delay: 30)
        startTimer()
        NSLog("Полноэкранная реклама была закрыта")
    }
    func interstitialDidClick(){
        NSLog("По полноэкранной рекламе кликнули")
    }
}

