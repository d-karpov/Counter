//
//  ViewController.swift
//  Counter
//
//  Created by Денис Карпов on 22.04.2024.
//

import UIKit

final class ViewController: UIViewController {
	
	//MARK: - IB Outlets
	@IBOutlet private weak var countLabel: UILabel!
	@IBOutlet private weak var historyText: UITextView!
	
	//MARK: - Private Properties
	private var count: Int = 0
	private var currentDateTime: String {
		Date.now.formatted(date: .numeric, time: .standard)
	}
	private enum Operation: String {
		case start = "История изменений:\n"
		case add = "значение изменено на +1\n"
		case sub = "значение изменено на -1\n"
		case clear = "значение сброшено\n"
		case error = "попытка уменьшить значение счётчика ниже 0\n"
	}
	
	// MARK: - Life Cycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		updateHistory(for: .start)
	}
	
	//MARK: - Private Methods
	private func updateCount(by number: Int) {
		count += number
		animatedCountTextUpdate()
	}
	
	private func updateHistory(for operation: Operation) {
		if operation == .start {
			historyText.text.append(contentsOf: operation.rawValue)
		} else {
			historyText.text.append(contentsOf: "[\(currentDateTime)]: \(operation.rawValue)")
		}
		let range = NSRange(location: historyText.text.count - 1, length: 0)
		historyText.scrollRangeToVisible(range)
	}
	
	private func animatedCountTextUpdate() {
		UIView.transition(
			with: countLabel,
			duration: 0.25,
			options: .transitionFlipFromBottom
		) {
			self.countLabel.text = "\(self.count)"
		}
	}
	
	//MARK: - IB Actions
	@IBAction private func addDidTap(_ sender: Any) {
		updateCount(by: 1)
		updateHistory(for: .add)
	}
	
	@IBAction private func subDidTap(_ sender: Any) {
		if count > 0 {
			updateCount(by: -1)
			updateHistory(for: .sub)
		} else {
			updateHistory(for: .error)
		}
	}
	
	@IBAction private func clearDidTap(_ sender: Any) {
		count = 0
		animatedCountTextUpdate()
		updateHistory(for: .clear)
	}
	
}
