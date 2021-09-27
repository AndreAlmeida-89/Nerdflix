//
//  LoadableView.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import UIKit

public protocol LoadableView: UIView {
  var contentView: UIView? { get set }
  func defaultSetup()
}

extension LoadableView {
  public func defaultSetup() {
    let nibName = String(describing: Self.self)
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
    guard let view = nibView else { return }
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
    contentView = view
  }
}






