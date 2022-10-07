//
//  LoadingView.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class LoadingView: UIView {

    lazy var indicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .gray
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blurView = {
        let blurErrect = UIBlurEffect(style: .systemMaterialLight)
        let blurView = UIVisualEffectView(effect: blurErrect)
        blurView.alpha = 0.5
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        [blurView, indicatorView].forEach{
            addSubview($0)
        }
//        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        blurView.frame = bounds
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
