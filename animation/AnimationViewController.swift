//
//  ViewController.swift
//  animation
//
//  Created by Ibrahim Berat Kaya on 23.03.2021.
//

import UIKit

class AnimationViewController: UIViewController {
    // MARK: Properties

    /// The field that controls the x value of the to be drawn circle.
    @IBOutlet var xValueField: UITextField!

    /// The field that controls the y value of the to be drawn circle.
    @IBOutlet var yValueField: UITextField!

    /// The top left label that will tell the pixel coordinate of the corner.
    @IBOutlet var topLeftLabel: UILabel!

    /// The bottom right label that will tell the pixel coordinate of the corner.
    @IBOutlet var bottomRightLabel: UILabel!

    /// The field that controls the first slider.
    @IBOutlet var firstSlider: UISlider!

    /// The field that controls the second slider.
    @IBOutlet var secondSlider: UISlider!

    /// The button that will be clicked to draw the circle.
    @IBOutlet var button: UIButton!

    /// The label of the circle stroke width slider.
    @IBOutlet var firstSliderLabel: UILabel!

    /// The label of the second slider.
    @IBOutlet var secondSliderLabel: UILabel!

    /// The label of the duration.
    @IBOutlet var durationLabel: UILabel!

    /// The field that controls the duration slider.
    @IBOutlet var durationSlider: UISlider!

    /// The segment controller.
    @IBOutlet var segmentControl: UISegmentedControl!

    @IBOutlet var saveImageButton: UIButton!
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        topLeftLabel.text = "(0, 0)"
        bottomRightLabel.text = "(\(view.frame.size.width),\(view.frame.size.height))"
        firstSlider.value = 25
        secondSlider.value = 5
        durationSlider.value = 5
    }

    // MARK: Actions

    @IBAction func onDurationValueChanged(_ sender: UISlider) {
        durationLabel.text = "Duration: \(String(format: "%.0f", durationSlider.value))"
    }

    @IBAction func onSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstSliderLabel.text = "Radius: \(String(format: "%.0f", firstSlider.value))"
            button.setTitle("Create Circle", for: .normal)
        } else {
            firstSliderLabel.text = "Width: \(String(format: "%.0f", firstSlider.value))"
            button.setTitle("Create Square", for: .normal)
        }
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        draw()
    }

    func draw() {
        if segmentControl.selectedSegmentIndex == 0 {
            addCircleView()
        } else {
            addRectangeView()
        }
    }

    @IBAction func onCircleRadiusChanged(_ sender: UISlider) {
        if segmentControl.selectedSegmentIndex == 0 {
            firstSliderLabel.text = "Radius: \(String(format: "%.0f", sender.value))"
        } else {
            firstSliderLabel.text = "Width: \(String(format: "%.0f", sender.value))"
        }
    }

    @IBAction func onCircleStrokeWidthChanged(_ sender: UISlider) {
        secondSliderLabel.text = "Stroke Width: \(String(format: "%.0f", sender.value))"
    }

    @IBAction func drawRandom(_ sender: UIButton) {
        randomDraw()
    }

    @IBAction func saveImagePressed(_ sender: UIButton) {
        captureScreen()
    }
    
    func addRectangeView() {
        guard let xStr = xValueField.text,
              let yStr = yValueField.text,
              let x = Double(xStr),
              let y = Double(yStr)
        else {
            displayAlert("Not a valid number!")
            return
        }
        if x > Double(view.frame.size.width) || y > Double(view.frame.size.height) || x < 0 || y < 0 {
            displayAlert("Out of bound error!")
            return
        }
        let width = Double(firstSlider.value)

        let strokeWidth = secondSlider.value

        if width < 0 || width > 250 {
            displayAlert("Rectangle width out of bound error!")
            return
        }

        let frame = CGRect(x: x/2-width/4, y: y/2-width/4, width: width, height: width)

        let rectangleView = RectangleView(frame: frame, color: UIColor.random, lineWidth: Double(strokeWidth))
        view.addSubview(rectangleView)
        view.sendSubviewToBack(rectangleView)
        rectangleView.draw(duration: TimeInterval(durationSlider.value))
    }

    /// Add a circle view to the main view.
    func addCircleView() {
        guard let xStr = xValueField.text,
              let yStr = yValueField.text,
              let x = Double(xStr),
              let y = Double(yStr)
        else {
            displayAlert("Not a valid number!")
            return
        }
        if x > Double(view.frame.size.width) || y > Double(view.frame.size.height) || x < 0 || y < 0 {
            displayAlert("Out of bound error!")
            return
        }
        let circleRadius = Double(firstSlider.value)

        let circleStrokeWidth = secondSlider.value

        if circleRadius <= 0 || circleRadius > 250 {
            displayAlert("Circle radius out of bound error!")
            return
        }

        let frame = CGRect(x: x, y: y, width: circleRadius, height: circleRadius)

        let circleView = CircleView(frame: frame, color: UIColor.random, lineWidth: Double(circleStrokeWidth), radius: circleRadius)
        view.addSubview(circleView)
        view.sendSubviewToBack(circleView)
        circleView.draw(duration: TimeInterval(durationSlider.value))
    }

    func displayAlert(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in }))
        present(alert, animated: true)

        let duration: Double = 5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }

    func updateFirstSlider(value: Float) {
        if segmentControl.selectedSegmentIndex == 0 {
            firstSliderLabel.text = "Radius: \(String(format: "%.0f", firstSlider.value))"
        } else {
            firstSliderLabel.text = "Width: \(String(format: "%.0f", firstSlider.value))"
        }
        firstSlider.value = value
    }

    func updateSecondSlider(value: Float) {
        secondSliderLabel.text = "Stroke Width: \(String(format: "%.0f", value))"
        secondSlider.value = value
    }

    func updateDurationSlider(value: Float) {
        durationLabel.text = "Duration: \(String(format: "%.0f", value))"
        durationSlider.value = value
    }

    func randomDraw() {
        let randomX = Double.random(in: 0...Double(view.frame.size.width))
        let randomY = Double.random(in: 0...Double(view.frame.size.height))
        let randomFirstSliderValue = Double.random(in: Double(firstSlider.minimumValue)...Double(firstSlider.maximumValue))
        let randomSecondSliderValue = Double.random(in: Double(secondSlider.minimumValue)...Double(secondSlider.maximumValue))
        let randomDurationSliderValue = Double.random(in: Double(durationSlider.minimumValue)...Double(durationSlider.maximumValue))
        xValueField.text = String(format: "%.0f", randomX)
        yValueField.text = String(format: "%.0f", randomY)
        updateFirstSlider(value: Float(randomFirstSliderValue))
        updateSecondSlider(value: Float(randomSecondSliderValue))
        updateDurationSlider(value: Float(randomDurationSliderValue))
        draw()
    }
    
    //Taken from https://stackoverflow.com/a/25457222/11701504.
    //Author: https://stackoverflow.com/users/1966109/imanou-petit.
    func captureScreen() -> UIImage? {
        stackView.isHidden = true
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        stackView.isHidden = false
        return screenshotImage
    }
}
