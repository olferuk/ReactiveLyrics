//
//  HtmlProcessor.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 22/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa
import Kanna

protocol HtmlRequest {
    func request(uri: String) -> Observable<String>
    func request(uri: String, params: [String: String]) -> Observable<String>
}

extension HtmlRequest {
    func request(uri: String, params: [String: String]) -> Observable<String> {
        return Observable.create { observer in
            let request = Alamofire.request(.GET, uri, parameters: params)
                .responseString { response in
                    if let error = response.result.error {
                        observer.onError(error)
                    }
                    if let value = response.result.value {
                        observer.onNext(value)
                        observer.onCompleted()
                    }
            }
            return AnonymousDisposable { request.cancel() }
        }
    }
    
    func request(uri: String) -> Observable<String> {
        return request(uri, params: [:])
    }
}
