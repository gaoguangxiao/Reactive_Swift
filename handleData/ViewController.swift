//
//  ViewController.swift
//  handleData
//
//  Created by gaoguangxiao on 2017/8/31.
//  Copyright © 2017年 gaoguangxiao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
   
    @IBOutlet weak var verifCodeText: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let disposeBag = DisposeBag()
        //never是创建sequence，但不发出任何事件
        //        let neverSepuence = Observable<String>.never()
        //        _ = neverSepuence.subscribe { (_) in
        //            print("This will never be printed")
        //        }.addDisposableTo(disposeBag)
        
        //empty创建一个空的sequence，只能发出一个complete事件
        //        Observable<String>.empty().subscribe { (event) in
        //            print("empty件",event)
        //        }.addDisposableTo(disposeBag)
        
        //        just创建一个sequence只能发出一中特定的事件，能正常结束
        //        Observable.just("GGX").subscribe { (event) in
        //            print("empty：",event)
        //        }.addDisposableTo(disposeBag)
        
        /*of创建一个sequence 能发出多个事件信号*/
        //        Observable.of("g","x","w").subscribe { (element) in
        //            print("of:",element)
        //        }.addDisposableTo(disposeBag)
        
        /*from从集合创建sequence，例如数组，字典，集合*/
        //        Observable.from(["q","w","e","r"]).subscribe(onNext: {
        //            print($0)
        //        }).addDisposableTo(disposeBag)
        
        //        Observable.from(["q","w","e","r"]).subscribe(onNext:{
        //            element in
        //            print(element)
        //        }).addDisposableTo(disposeBag)'
        
        /*create自定义观察对象的 sequence*/
//        myJust(element: "Hello").subscribe { (event) in
//               print("create:",event)
//            }.addDisposableTo(disposeBag)

        configRac()
    }
    
    func myJust(element:String) -> Observable<String> {
        return Observable.create { observer in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    func configRac()  {
        
        let usernameValid = userName.rx.text.orEmpty
            .map { $0.characters.count > 0  }
            .shareReplay(1)
       
        //map转换不增加 就是对每个元素都用函数做一次转换，挨个映射一遍。
        let mobileNumberValid = mobileNumber.rx.text.orEmpty
            .map { $0.characters.count >= 11 }
            .shareReplay(1)
        
        let verifCodeTextValid = verifCodeText.rx.text.orEmpty
            .map { $0.characters.count > 0 }
            .shareReplay(1)
        
//输入框 输入状态改变
        verifCodeText.rx.controlEvent(UIControlEvents.editingChanged).subscribe { (text) in
            print(text.element)
            }.disposed(by: disposeBag)
       //输入框 数值改变监听
//        verifCodeText.rx.value.orEmpty.subscribe { (event) in
//            print(event)
//        }.disposed(by: disposeBag)

        let everyThing = Observable.combineLatest(usernameValid, mobileNumberValid,verifCodeTextValid) { $0 && $1 && $2}.shareReplay(1)
        everyThing.bind(to: nextBtn.rx.isEnabled).disposed(by: disposeBag)
        
       
    }
    @IBAction func sendVerifCodeClick(_ sender: UIButton) {
        verifCodeText.text = "11111"
        
        configRac()
        
    }
    
    @IBAction func registClick(_ sender: UIButton) {
        print("点击了")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

