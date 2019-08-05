//
//  ViewController.swift
//  KolaseFotoRx
//
//  Created by Luthfi Fathur Rahman on 05/08/19.
//  Copyright © 2019 HOOQ. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAddPhoto: UIBarButtonItem!
    @IBOutlet weak var img_photoCollage: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    private let disposeBag = DisposeBag()
    private let images = Variable<[UIImage]>([])
    private var imageCache = [Int]()
    
    private let constant = Constant.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        images.asObservable()
            .subscribe(onNext: { [weak self] photos in
                guard let self = self else { return }
                
                guard let preview = self.img_photoCollage else { return }
                
                preview.image = UIImage.collage(images: photos, size: preview.frame.size)
                
        })
        .disposed(by: disposeBag)
        
    }
    
    private func updateUI() {
        img_photoCollage.layer.borderColor = constant.purpleColor.cgColor
        img_photoCollage.layer.borderWidth = 2
        btnSave.backgroundColor = constant.purpleColor
    }

}

extension ViewController {
    @IBAction func actionClear(_ sender: UIButton) {
        images.value = []
        imageCache = []
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        images.value.append(UIImage(named: "fotoOrang")!)
    }
}

