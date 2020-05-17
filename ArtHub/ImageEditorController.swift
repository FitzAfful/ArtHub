//
//  ImageEditorController.swift
//  ArtHub
//
//  Created by Fitzgerald Afful on 14/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

class ImageEditorController: UIViewController, XMSegmentedControlDelegate {

    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var label: MyLabel!
    @IBOutlet weak var editorsContainerView: UIView!
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
        let titles: [String] = ["Text", "Canvas", "Image"]
        let segmentedControl = HMSegmentedControl(sectionTitles: titles) //HMSegmentedControl(sectionImages: selectors, sectionSelectedImages: selectorsSelected, titlesForSections: titles)
        segmentedControl.imagePosition = .aboveText
        segmentedControl.selectionIndicatorHeight = 2.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectionIndicatorLocation = .top;
        segmentedControl.selectionStyle = .fullWidthStripe;
        segmentedControl.segmentWidthStyle = .fixed;
        segmentedControl.frame = segmentView.frame
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        view.addSubview(segmentedControl)

        let textEditor = createTextEditorView()
        editorsContainerView.addSubview(textEditor)


        label.text = "Jesus wept!"
        label.color = UIColor.white
        label.stroke = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.widgetColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
    }

    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
    }

    func createTextEditorView() -> TextEditorView {
        let myView = (Bundle.main.loadNibNamed("TextEditorView", owner: self, options: nil)![0] as? UIView)!
        let textEditorView = myView as! TextEditorView
        let selectors: [UIImage] = [UIImage(named: "left_aligned_unselected")!, UIImage(named: "center_aligned_unselected")!, UIImage(named: "right_aligned_unselected")!]
        let alignmentSegmentedControl = textEditorView.alignmentView!
        alignmentSegmentedControl.segmentIcon = selectors
        alignmentSegmentedControl.selectedItemHighlightStyle = .background
        alignmentSegmentedControl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        alignmentSegmentedControl.highlightColor = UIColor.clear
        alignmentSegmentedControl.selectedSegment = 1
        alignmentSegmentedControl.highlightTint = UIColor.init(hexString: "008F00")
        alignmentSegmentedControl.delegate = self
        return textEditorView
    }

    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        print("SegmentedControl Selected Segment: \(selectedSegment)")
        switch selectedSegment {
        case 0:
            let paraStyle = NSMutableParagraphStyle()
            //paraStyle.lineSpacing = 0.0
            paraStyle.alignment = NSTextAlignment.left
            label.paragraphStyle = paraStyle
        case 1:
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.alignment = NSTextAlignment.center
            label.paragraphStyle = paraStyle
        case 2:
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.alignment = NSTextAlignment.right
            label.paragraphStyle = paraStyle
        default:
            break
        }
    }
}
