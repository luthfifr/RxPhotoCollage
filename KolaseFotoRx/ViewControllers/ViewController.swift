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
        
        setupUI()
        
        images.asObservable()
            .subscribe(onNext: { [weak self] photos in
                guard let self = self else { return }
                
                self.img_photoCollage.image = UIImage.collage(images: photos, size: self.img_photoCollage.frame.size)
                
                self.updateUI(photos: photos)
                
        })
        .disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        img_photoCollage.layer.borderColor = constant.purpleColor.cgColor
        img_photoCollage.layer.borderWidth = constant.imgPreviewBorderWidth
        btnSave.backgroundColor = constant.purpleColor
    }
    
    private func updateUI(photos: [UIImage]) {
        btnSave.isEnabled =  photos.count == 0 || photos.count < constant.photoLimit
        btnSave.backgroundColor = btnSave.isEnabled ? constant.purpleColor : constant.disabledBtnColor
        btnClear.isEnabled = photos.count > 0
        btnClear.backgroundColor = btnClear.isEnabled ? constant.redBtnClearColor : constant.disabledBtnColor
        btnAddPhoto.isEnabled = photos.count < constant.photoLimit
        title = photos.count > 0 ? "\(photos.count) Foto" : "Kolase Foto"
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
    
    @IBAction func actionAddPhoto(_ sender: UIBarButtonItem) {
        guard let papanCerita = storyboard else { return }
        
        let destinationVC = papanCerita.instantiateViewController(withIdentifier: "tambahFoto") as! TambahFotoViewController
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

