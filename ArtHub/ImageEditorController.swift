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
    @IBOutlet weak var label: MyLabel!
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


        label.text = "Whoever believes in the Son has eternal life, but whoever rejects the Son will not see life. For God's wrath remains on them"
        label.color = UIColor.white
        label.stroke = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.widgetColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
    }

    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
    }

}
