//
//  ext_DispatchQueue.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation


func runInMain<T>(_ block:()->(T)) -> T {
    let t: T
    if (Thread.current == Thread.main){
        t = block()
    } else{
        t = DispatchQueue.main.sync(execute: block)
    }
    return t
}

func runInMainAsync(time: DispatchTimeInterval = .seconds(0), _ block:(()->())?) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        block?()
    }
}
