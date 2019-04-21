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
open class SMControl: UIControl {
	
	public typealias ActionBlock = (SMControl) -> ()
	
	private var actionsMap = [UInt : ActionBlock]()
	
	
	// MARK: - Initializations

	public init() {
		super.init(frame: CGRect.zero)
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	// MARK: - Functions
	
	public func addActionBlock(event: UIControl.Event, block: @escaping ActionBlock) {
		actionsMap[event.rawValue] = block
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
	}
	
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		execute(event: .touchDown)
	}
	
	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		execute(event: .touchCancel)
	}

}
