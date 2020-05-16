//
//  ImageEditorController.swift
//  ArtHub
//
//  Created by Fitzgerald Afful on 14/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class ImageEditorController: UIViewController {

    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var preEditedImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.preEditedImage
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width
        imageViewHeightConstraint.constant = screenWidth
        
        //let selectors: [UIImage] = []
        //let selectorsSelected: [UIImage] = []
        let titles: [String] = ["Font", "Text", "Canvas", "Image"]
        let segmentedControl = HMSegmentedControl(sectionTitles: titles) //HMSegmentedControl(sectionImages: selectors, sectionSelectedImages: selectorsSelected, titlesForSections: titles)
        segmentedControl.imagePosition = .aboveText
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectionIndicatorLocation = .top;
        segmentedControl.selectionStyle = .fullWidthStripe;
        segmentedControl.segmentWidthStyle = .fixed;
        segmentedControl.frame = segmentView.frame
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        view.addSubview(segmentedControl)
    }

    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
    }

}
