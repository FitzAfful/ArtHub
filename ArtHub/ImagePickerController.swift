//
//  ViewController.swift
//  ArtHub
//
//  Created by Fitzgerald Afful on 13/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class ImagePickerController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!

    var bgImages: [UIImage] = [UIImage(named: "bgImage1")!,
                               UIImage(named: "bgImage2")!,
                               UIImage(named: "bgImage3")!,
                               UIImage(named: "bgImage4")!,
                               UIImage(named: "bgImage5")!,
                               UIImage(named: "bgImage6")!]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startPicker(_ sender: Any) {
        startBackgroundPicker()
    }

    func startBackgroundPicker(){
        let mainAlert = UIAlertController(title: "Choose Background", message: "Choose Type of Background for text", preferredStyle: .actionSheet)
        mainAlert.addAction(UIAlertAction(title: "Image", style: .default, handler: { (action) in
            let alert = UIAlertController(style: .actionSheet)
            alert.addImagePicker(
                flow: .vertical,
                paging: false,
                images: self.bgImages,
                selection: .single(action: { image in
                    if let image = image {
                        self.bgImageView.image = image
                        delay(2) {
                            self.moveToImageEditor(image: image)
                        }
                    }
                }))
            alert.title = "Create Image"
            alert.message = "Choose background image for text"
            alert.addAction(title: "OK", style: .cancel)
            alert.show()
        }))
        mainAlert.addAction(UIAlertAction(title: "Color", style: .default, handler: { (action) in
            let alert = UIAlertController(style: .actionSheet)
            alert.addColorPicker(color: UIColor(hex: 0xFF2DC6)) { color in
                if let image = UIImage(color: color, size: CGSize(width: 500, height: 500)) {
                    self.bgImageView.image = image
                    self.moveToImageEditor(image: image)
                }
            }
            alert.addAction(title: "Cancel", style: .cancel)
            alert.show()
        }))
        mainAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(mainAlert, animated: true, completion: nil)
    }

    func moveToImageEditor(image: UIImage) {
        guard let vc = Bundle.main.loadNibNamed("ImageEditorController", owner: self, options: nil)![0] as? ImageEditorController  else { return }
        let vcNav = UINavigationController(rootViewController: vc)
        vcNav.modalPresentationStyle = .fullScreen
        (vcNav.topViewController as! ImageEditorController).preEditedImage = image
        self.present(vcNav, animated: true, completion: nil)
    }
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
