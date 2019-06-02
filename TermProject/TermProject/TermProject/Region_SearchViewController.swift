

import UIKit
import Speech

class Region_SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //========================================================================
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    
    var SIGUN_NMList : [String]
    = [ "가평군",
        "과천시",
        "광명시",
        "광주시",
        "고양시",
        "구리시",
        "군포시",
        "김포시",
        "남양주시",
        "동두천시",
        "부천시",
        "성남시",
        "수원시",
        "시흥시",
        "안산시",
        "안성시",
        "안양시",
        "양주시",
        "양평군",
        "여주시",
        "연천군",
        "오산시",
        "용인시",
        "의왕시",
        "의정부시",
        "이천시",
        "파주시",
        "평택시",
        "포천시",
        "하남시",
        "화성시"]
    var SIGUN_NM : String = "가평군"
    var SIGUN_NM_utf8 : String = ""
    var url : String = "https://openapi.gg.go.kr/Genrestrtcate?KEY=aade671fa9c8412ba273f83db26a49e6"

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SIGUN_NMList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SIGUN_NMList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 1:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 2:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 3:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 4:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 5:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 6:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 7:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 8:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 9:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 10:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 11:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 12:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 13:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 14:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 15:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 16:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 17:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 18:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 19:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 20:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 21:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 22:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 23:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 24:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 25:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 26:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 27:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 28:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 29:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 30:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        default:
            SIGUN_NM = "\(SIGUN_NMList[0])"
            break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestorantList"{
            if let navController = segue.destination as? UINavigationController{
                SIGUN_NM_utf8 = SIGUN_NM.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                if let listTableViewController = navController.topViewController as? R_ListTableViewController{
                    listTableViewController.url = url + "&SIGUN_NM=" + SIGUN_NM_utf8
                }
            }
        }
    }
    
    // ===============================================================

    
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    //private let speechRecognizer = SFSpeechRecognizer()!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    @IBAction func startTranscribing(_ sender: Any){
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
        
    }
    
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask{
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.allowAirPlay)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else {
            fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed")
        }
        
        let inputNode = audioEngine.inputNode
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest){ result, error in
            var finished = false
            
            if let result = result{
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){ (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.speechRecognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
    }
    
    @IBAction func stopTranscribing(_ sender: Any){
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            stopButton.isEnabled = false
            transcribeButton.isEnabled = true
        }
        
        switch(self.myTextView.text){
        case "가평군": self.pickerView.selectRow(0, inComponent: 0, animated: true)
            SIGUN_NM = "가평군"
            break
        case "과천시": self.pickerView.selectRow(1, inComponent: 0, animated: true)
            SIGUN_NM = "과천시"
            break
        case "광명시": self.pickerView.selectRow(2, inComponent: 0, animated: true)
            SIGUN_NM = "광명시"
            break
        case "광주시": self.pickerView.selectRow(3, inComponent: 0, animated: true)
            SIGUN_NM = "광주시"
            break
        case "고양시": self.pickerView.selectRow(4, inComponent: 0, animated: true)
            SIGUN_NM = "고양시"
            break
        case "구리시": self.pickerView.selectRow(5, inComponent: 0, animated: true)
            SIGUN_NM = "구리시"
            break
        case "군포시": self.pickerView.selectRow(6, inComponent: 0, animated: true)
            SIGUN_NM = "군포시"
            break
        case "김포시": self.pickerView.selectRow(7, inComponent: 0, animated: true)
            SIGUN_NM = "김포시"
            break
        case "남양주시": self.pickerView.selectRow(8, inComponent: 0, animated: true)
            SIGUN_NM = "남양주시"
            break
        case "동두천시": self.pickerView.selectRow(9, inComponent: 0, animated: true)
            SIGUN_NM = "동두천시"
            break
        case "부천시": self.pickerView.selectRow(10, inComponent: 0, animated: true)
            SIGUN_NM = "부천시"
            break
        case "성남시": self.pickerView.selectRow(11, inComponent: 0, animated: true)
            SIGUN_NM = "성남시"
            break
        case "수원시": self.pickerView.selectRow(12, inComponent: 0, animated: true)
            SIGUN_NM = "수원시"
            break
        case "시흥시": self.pickerView.selectRow(13, inComponent: 0, animated: true)
            SIGUN_NM = "시흥시"
            break
        case "안산시": self.pickerView.selectRow(14, inComponent: 0, animated: true)
            SIGUN_NM = "안산시"
            break
        case "안성시": self.pickerView.selectRow(15, inComponent: 0, animated: true)
            SIGUN_NM = "안성시"
            break
        case "안양시": self.pickerView.selectRow(16, inComponent: 0, animated: true)
            SIGUN_NM = "안양시"
            break
        case "양주시": self.pickerView.selectRow(17, inComponent: 0, animated: true)
            SIGUN_NM = "양주시"
            break
        case "양평군": self.pickerView.selectRow(18, inComponent: 0, animated: true)
            SIGUN_NM = "양평군"
            break
        case "여주군": self.pickerView.selectRow(19, inComponent: 0, animated: true)
            SIGUN_NM = "여주군"
            break
        case "연천군": self.pickerView.selectRow(20, inComponent: 0, animated: true)
            SIGUN_NM = "연천군"
            break
        case "오산시": self.pickerView.selectRow(21, inComponent: 0, animated: true)
            SIGUN_NM = "오산시"
            break
        case "용인시": self.pickerView.selectRow(22, inComponent: 0, animated: true)
            SIGUN_NM = "용인시"
            break
        case "의왕군": self.pickerView.selectRow(23, inComponent: 0, animated: true)
            SIGUN_NM = "의왕군"
            break
        case "의정부시": self.pickerView.selectRow(24, inComponent: 0, animated: true)
            SIGUN_NM = "의정부시"
            break
        case "이천시": self.pickerView.selectRow(25, inComponent: 0, animated: true)
            SIGUN_NM = "이천시"
            break
        case "파주시": self.pickerView.selectRow(26, inComponent: 0, animated: true)
            SIGUN_NM = "파주시"
            break
        case "평택시": self.pickerView.selectRow(27, inComponent: 0, animated: true)
            SIGUN_NM = "평택시"
            break
        case "포천시": self.pickerView.selectRow(28, inComponent: 0, animated: true)
            SIGUN_NM = "포천시"
            break
        case "하남시": self.pickerView.selectRow(29, inComponent: 0, animated: true)
            SIGUN_NM = "하남시"
            break
        case "화성시": self.pickerView.selectRow(30, inComponent: 0, animated: true)
            SIGUN_NM = "화성시"
            break
        default: break
        }
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization {authStatus in
            
            OperationQueue.main.addOperation{
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user.", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
            
        }
    }
    
    
    // ===============================================================
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()

        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
    }
    
    

}
