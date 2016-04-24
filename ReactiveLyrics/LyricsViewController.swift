//
//  HelpfulViewController.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 22/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kanna

class LyricsViewController: UIViewController {
    @IBOutlet weak var lyricsView: UITextView!
    @IBOutlet weak var searchBar: UITextField!

    let dispose = DisposeBag()

    var textSignal: Observable<String> {
        get {
            return searchBar.rx_text
                .filter { $0.characters.count > 4 }
                .throttle(0.5, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [AzLyrics().search, PLyrics().search, UrbanLyrics().search]
            .map { textSignal.flatMap($0) }.toObservable().merge()
            .catchError(errorPrintHandler)
            .bindTo(lyricsView.rx_text)
            .addDisposableTo(dispose)
    }
}

// MARK: Error handling
extension LyricsViewController {
    var errorPrintHandler: (ErrorType) -> Observable<String> {
        get {
            return { error in
                print(error)
                return Observable.never()
            }
        }
    }
}
