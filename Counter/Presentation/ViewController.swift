//
//  ViewController.swift
//  Counter
//
//  Created by Денис Карпов on 22.04.2024.
//

import UIKit

class ViewController: UIViewController {
	
//MARK: - IB Outlets
	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var historyText: UITextView!
	
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
	
//MARK: - IB Actions
	@IBAction func addDidTap(_ sender: Any) {
		updateCount(by: 1)
		updateHistory(for: .add)
	}
	
	@IBAction func subDidTap(_ sender: Any) {
		if count > 0 {
			updateCount(by: -1)
			updateHistory(for: .sub)
		} else {
			updateHistory(for: .error)
		}
	}
	
	@IBAction func clearDidTap(_ sender: Any) {
		count = 0
		animatedCountTextUpdate()
		updateHistory(for: .clear)
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
}
