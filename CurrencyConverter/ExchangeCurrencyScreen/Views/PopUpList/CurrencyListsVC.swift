//
//  CurrencyListsVC.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let backgroundColor = UIColor.AppColor.ghostWhiteColor
        static let texColor = UIColor.AppColor.midnightExpressColor
        static let buttonTitlesColor = UIColor.AppColor.royalBlueColor
        static let dividerColor = UIColor.AppColor.hawkesBlue
    }
    
    struct Image {
        static let backButtonIcon = UIImage(named: "BackButtonGreyColor")
    }
    
    struct Text {
        static let screenTitle = "Currency Type"
        static let cancelButtonTitle = "Cancel"
    }
}

fileprivate class CurrencyViewTableViewCell: UITableViewCell {
    static let identifier = "CurrencyViewTableViewCell"
    
    lazy var currencyImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var currencyDescription: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = Styles.Color.texColor ?? .black
        view.font = UIFont.appFont(type: .regular, size: 14)
        view.numberOfLines = 1
        return view
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Styles.Color.dividerColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = UIView()
        view.backgroundColor = .clear
        selectedBackgroundView = view
        
        backgroundColor = Styles.Color.backgroundColor

        contentView.addSubview(currencyImage)
        contentView.addSubview(currencyDescription)
        contentView.addSubview(divider)
        
        currencyImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        currencyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        currencyImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        currencyImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        currencyImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        currencyDescription.centerYAnchor.constraint(equalTo: currencyImage.centerYAnchor).isActive = true
        currencyDescription.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 8).isActive = true
        currencyDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyImage.image = nil
        currencyDescription.text = nil
    }
}

final class CurrencyListViewController: UIViewController {
    var selectedValue: ((_ value: CurrencyType) -> ())?
    
    private var sourceData: [CurrencyType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = Styles.Color.backgroundColor
        view.register(CurrencyViewTableViewCell.self, forCellReuseIdentifier: CurrencyViewTableViewCell.identifier)
        return view
    }()
    
    init(currentCurrency: CurrencyType) {
        super.init(nibName: nil, bundle: nil)
        sourceData = initSourceData(currentCurrency)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        initUI()
    }
    
    private func initUI() {
        view.backgroundColor = Styles.Color.backgroundColor
        navigationItem.title = Styles.Text.screenTitle
        navigationController?.navigationBar.tintColor = Styles.Color.buttonTitlesColor
        
        let backButton = UIBarButtonItem(title: Styles.Text.cancelButtonTitle,
                                         style:.done, target:self, action: #selector(closeScreen))
        let navigationTitleFont = UIFont.appFont(type: .medium, size: 16)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: navigationTitleFont], for: .normal)
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc
    private func closeScreen() {
        self.dismiss(animated: true)
    }
}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyViewTableViewCell.identifier, for: indexPath) as! CurrencyViewTableViewCell
        
        let data = sourceData[indexPath.row]
        cell.currencyImage.image = data.image.square
        cell.currencyDescription.text = data.description.name
        cell.divider.isHidden = indexPath.row == (sourceData.count - 1) ? true : false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue?(sourceData[indexPath.row])
        
        DispatchQueue.main.async { [weak self] in
            self?.closeScreen()
        }
    }
    
    private func initSourceData(_ currentCurrency: CurrencyType) -> [CurrencyType] {
        var sourceData = CurrencyType.listOfAll
        sourceData.removeAll(where: { $0 == currentCurrency })
        return sourceData
    }
}
