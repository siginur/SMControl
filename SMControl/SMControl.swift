//
//  SMControl.swift
//  SMControl
//
//  Created by Alexey Siginur on 02/01/2019.
//  Copyright © 2019 Alexey Siginur. All rights reserved.
//

import UIKit

/**
Control structure
**/
@IBDesignable
open class SMControl: UIControl {
	
	public typealias ActionBlock = (SMControl) -> ()
	
	private var actionsMap = [UInt : ActionBlock]()
	private var imageView = UIImageView()
	private var scaleImageConstraint: NSLayoutConstraint?
	
	@IBInspectable
	public var image: UIImage? {
		set {
			imageView.image = newValue
		}
		get {
			return imageView.image
		}
	}
	
	@IBInspectable
	public var imageScale: CGFloat = 1 {
		didSet {
			if let constraint = scaleImageConstraint {
				imageView.removeConstraint(constraint)
			}
			scaleImageConstraint = imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: imageScale)
			scaleImageConstraint?.isActive = true
		}
	}
	
	
	// MARK: - Initializations
	
	public init() {
		super.init(frame: CGRect.zero)
		setup()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	private func setup() {
		self.addSubview(imageView)
		imageView.contentMode = .scaleAspectFit
		imageView.isUserInteractionEnabled = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0))
	}
	
	
	// MARK: - Functions
	
	public func addActionBlock(event: UIControl.Event, block: @escaping ActionBlock) {
		actionsMap[event.rawValue] = block
	}
	
	public func setImage(_ image: UIImage, scale: CGFloat) {
		self.image = image
		self.imageScale = scale
	}
	
	private func execute(event: UIControl.Event) {
		sendActions(for: event)
		if let block = actionsMap[event.rawValue] {
			block(self)
		}
		
	}
	
	
	// MARK: - Touches
	
	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let location = touches.first?.location(in: self) else {
			return
		}
		
		execute(event: bounds.contains(location) ? .touchUpInside : .touchUpOutside)
		imageView.alpha = 1
	}
	
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		execute(event: .touchDown)
		imageView.alpha = 0.7
	}
	
	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		execute(event: .touchCancel)
		imageView.alpha = 1
	}
	
}
