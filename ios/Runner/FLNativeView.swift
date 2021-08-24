//
//  FLNativeView.swift
//  Runner
//
//  Created by Daniel Newville on 8/24/21.
//

import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger
        )
    }
}

class FLNativeView: NSObject, FlutterPlatformView, UIDropInteractionDelegate {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView) {
        _view.addInteraction(UIDropInteraction(delegate: self))
        
//        _view.backgroundColor = UIColor.black
        let nativeLabel = UILabel()
        nativeLabel.text = "Native view from iOS. You shouldn't be able to see this..."
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48)
        _view.addSubview(nativeLabel)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print(session.items)
        for dragItem in session.items {
//            dragItem.itemProvider.loadFileRepresentation(forTypeIdentifier: <#T##String#>, completionHandler: <#T##(URL?, Error?) -> Void#>)
            dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (obj, err) in
                if let err = err {
                    print("Failed to load the dragged item: ", err)
                    return
                }
                
                guard let draggedImage = obj as? UIImage else { return }
                
                let imageView = UIImageView(image: draggedImage)
                
                DispatchQueue.main.async {
                    self._view.addSubview(imageView)
                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                }
                
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // return session.canLoadObjects(ofClass: UIImage.self)
        return true;
    }
}
