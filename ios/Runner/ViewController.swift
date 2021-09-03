//
//  ViewController.swift
//  Runner
//
//  Created by Daniel Newville on 8/23/21.
//

//import UIKit
//
//class ViewController: UIViewController, UIDropInteractionDelegate {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addInteraction(UIDropInteraction(delegate: self))
//    }
//    
//    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
//        for dragItem in session.items {
//            dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (obj, err) in
//                if let err = err {
//                    print("Failed to load the dragged item: ", err)
//                    return
//                }
//                
//                guard let draggedImage = obj as? UIImage else { return }
//                
//                let imageView = UIImageView(image: draggedImage)
//                
//                DispatchQueue.main.async {
//                    self.view.addSubview(imageView)
//                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
//                }
//                
//            }
//        }
//    }
//    
//    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
//        return UIDropProposal(operation: .copy)
//    }
//    
//    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: UIImage.self)
//    }
//}
