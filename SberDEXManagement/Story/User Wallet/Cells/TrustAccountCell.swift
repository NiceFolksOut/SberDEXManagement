//
//  TrustAccountCell.swift
//  SberDEXManagement
//
//  Created by Артмеий Шлесберг on 17/02/2018.
//  Copyright © 2018 NFO. All rights reserved.
//

import Foundation
import UIKit

class PortfolioTitleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = StandardLabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .warmGrey, text: "Состав портфеля:")

        let separator = UIView()
            .with(backgroundColor: .sbrWhite)
        
        addSubviews([ label, separator])
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(1)
        }

        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HistoryTitleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = StandardLabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .warmGrey, text: "История операций:")
        
        let separator = UIView()
            .with(backgroundColor: .sbrWhite)
        
        addSubviews([ label, separator])
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(1)
        }
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ActivePositionCell: UITableViewCell {
    
    private var titleLabel = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
    private var amountLabel = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
    private var priceChangeLabel = StandardLabel(font: .systemFont(ofSize: 15, weight: .medium), textColor: .black)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let container = UIView()
        .with(backgroundColor: .white)
        .with(roundedEdges: 15)
        .withShadow()
        
        addSubview(container)
        container.addSubviews([titleLabel, amountLabel, priceChangeLabel])
        
        container.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(76)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        amountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        priceChangeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    func setuped(with active: ActivePosition) -> Self {
        titleLabel.text = active.titile
        amountLabel.text = "\(Float(active.count) * active.price) SR"
        priceChangeLabel.text = "1.23  SR (+1,2%)"
        priceChangeLabel.textColor = .algaeGreen
        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TransactionCell: UITableViewCell {
    
    private var titleLabel = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
    private var amountLabel = StandardLabel(font: .systemFont(ofSize: 20, weight: .medium), textColor: .black)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let separator = UIView()
            .with(backgroundColor: .sbrWhite)
        
        addSubviews([titleLabel, amountLabel, separator])
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.bottom.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        amountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        selectionStyle = .none
        
    }
    
    func setuped(with transaction: Transaction) -> Self {
        titleLabel.text = "\(transaction.amount) \(transaction.active.titile)"
        amountLabel.text = "\(Float(transaction.amount * -1) * transaction.active.price) SR"
        amountLabel.textColor = transaction.amount < 0 ? .algaeGreen : .red
        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContractCell: UITableViewCell {

    private var titleLabel = StandardLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32)
            $0.bottom.equalToSuperview().offset(-25)
            $0.leading.equalToSuperview().offset(18)
        }

        accessoryType = .disclosureIndicator

    }

    func setuped(transactionAddress: String) -> Self {
        titleLabel.text = "Активный контракт: \(transactionAddress.prefix(8))..."
        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
