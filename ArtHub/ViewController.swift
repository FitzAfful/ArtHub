//
//  ViewController.swift
//  ArtHub
//
//  Created by Fitzgerald Afful on 13/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

        let alert = UIAlertController(style: .actionSheet)
        alert.addImagePicker(
            flow: .vertical,
            paging: false,
            images: bgImages,
            selection: .single(action: { image in

            }))
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }

}

