//
//  WithdrawViewController.swift
//  SberDEXManagement
//
//  Created by Артмеий Шлесберг on 17/02/2018.
//  Copyright © 2018 NFO. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class WithdrawViewController: UIViewController {
    
    
    var textField = UITextField()
        .with(placeholder: "₽")
        .with(font: .systemFont(ofSize: 35, weight: .bold))
        .withBottomBorder()
    
    var sumLabel  = StandardLabel(font: .systemFont(ofSize: 13, weight: .medium), textColor: .warmGrey, text: "Сумма вывода")
    
    private var addButton = StandardRoundEdgeButton()
        .with(font: .systemFont(ofSize: 18, weight: UIFont.Weight.bold))
        .with(title: "Вывести")
        .with(titleColor: .white)
        .with(backgroundColor: .algaeGreen)
    
    private var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        textField.textColor = .algaeGreen
        let arrow = UIImageView(image: #imageLiteral(resourceName: "rightArrow"))
            .with(backgroundColor: .white)
            .with(contentMode: .scaleAspectFit)
        let sep1 = UIView()
            .with(backgroundColor: .sbrWhite)
        let sep2 = UIView()
            .with(backgroundColor: .sbrWhite)
        let sum1 = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .greyishBrown, text: "234 000,03 ₽")
        let sum2 = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .greyishBrown, text: "\(SbercoinWallet.shared.valuteAmount) SR")
        let name1 = StandardLabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: .greyishBrown, text: "Счет *9931")
        let name2 = StandardLabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: .greyishBrown, text: "Кошелёк")
        
        view.addSubviews([ textField, sumLabel, addButton, sep1,
                           sep2, arrow,
                           sum1,
                           sum2,
                           name1,
                           name2 ])
        
        arrow.snp.makeConstraints {
            $0.centerY.equalTo(sep1)
            $0.width.equalTo(46)
            $0.height.equalTo(13)
            $0.trailing.equalToSuperview().inset(52)
        }
        sum2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(19)
        }
        name2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalTo(sum2.snp.bottom).offset(8)
        }
        sep1.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(name2.snp.bottom).offset(16)
            $0.height.equalTo(1)
        }
        
        sum1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalTo(sep1.snp.bottom).offset(19)
        }
        name1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.top.equalTo(sum1.snp.bottom).offset(8)
        }
        sep2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(name1.snp.bottom).offset(16)
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sep2).offset(24)
        }
        sumLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(45)
            $0.top.equalTo(sumLabel.snp.bottom).offset(42)
        }
        
        addButton.rx.tap.subscribe(onNext: {
            if let text = self.textField.text,
                let amount = Float(text),
                let _ = try? SbercoinWallet.shared.spend(amount: amount) {
                self.navigationController?.popViewController(animated: true)
            }
        })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Вывести"
        self.navigationController?.navigationBar.tintColor = .algaeGreen
    }
}
