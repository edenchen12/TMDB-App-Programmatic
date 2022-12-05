//
//  TMDBEmptyStateView.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBEmptyStateView: UIView {
        
        let messageLabel    = TMDBTitleLabel(textAlignment: .center, fontSize: 28)
        let logoImageView   = UIImageView()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        convenience init(message: String) {
            self.init(frame: .zero)
            messageLabel.text = message
        }
        
        
        private func configure() {
            addSubview(messageLabel)
            addSubview(logoImageView)
            configureMessageLabel()
            configureLogoImageView()
        }
        
        
        private func configureMessageLabel() {
            messageLabel.numberOfLines  = 3
            messageLabel.textColor      = .secondaryLabel
            
            let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -90 : -150

            NSLayoutConstraint.activate([
                messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
                messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
                messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
                messageLabel.heightAnchor.constraint(equalToConstant: 200)
            ])
        }
        
        
        private func configureLogoImageView() {
            logoImageView.image = Images.emptyStateLogo
            logoImageView.tintColor = .lightGray
            logoImageView.contentMode = .scaleAspectFit
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            
            
            NSLayoutConstraint.activate([
                logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                logoImageView.widthAnchor.constraint(equalToConstant: 350),
                logoImageView.heightAnchor.constraint(equalToConstant: 350),
            ])
        }
    }

