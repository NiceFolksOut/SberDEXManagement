//
//  AddTrustAccountCell.swift
//  SberDEXManagement
//
//  Created by Артмеий Шлесберг on 17/02/2018.
//  Copyright © 2018 NFO. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class AddTrustAccountCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let image = UIImageView(image: #imageLiteral(resourceName: "plus2"))
        let label = StandardLabel(font: .systemFont(ofSize: 17, weight: .bold), textColor: .greyishBrown, text: "Создать доверительный счет")
        let separator = UIView()
        .with(backgroundColor: .sbrWhite)

        addSubviews([image, label, separator])
        
        image.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).offset(16)
            
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
